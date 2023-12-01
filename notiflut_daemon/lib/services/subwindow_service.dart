import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notiflut/messages/daemon_event.pbserver.dart';
import 'package:wayland_multi_window/wayland_multi_window.dart';

import 'package:notiflut/messages/daemon_event.pb.dart' as daemon_event
    show Notification;

import '../messages/google/protobuf/timestamp.pb.dart';

enum SubWindowEvents {
  invokeAction,
  notificationClosed;

  factory SubWindowEvents.fromString(String value) {
    return SubWindowEvents.values.firstWhere((e) => e.toString() == value,
        orElse: () => throw Exception("Not an element of SubWindowEvents"));
  }
}

class SubWindowService extends ChangeNotifier {
  List<(daemon_event.Notification, Timer?)> popups = [];
  bool isHidden = true;
  final int windowId;
  final LayerShellController layerController;

  SubWindowService(this.windowId)
      : layerController = LayerShellController.fromWindowId(windowId);

  void init() {
    WaylandMultiWindow.setMethodHandler(_handleEvents);
  }

  @override
  void dispose() {
    WaylandMultiWindow.setMethodHandler(null);
    super.dispose();
  }

  Future<dynamic> _handleEvents(MethodCall call, int fromWindowId) async {
    final data = call.arguments as List<int>;
    final notification = daemon_event.Notification.fromBuffer(data);

    if (popups.isEmpty) {
      layerController.show();
    }

    final timer = switch (notification.hints.urgency) {
      Hints_Urgency.Critical => null,
      _ => schedulePopupCleanUp(notification.id, notification.createdAt),
    };

    popups.insert(0, (notification, timer));
    popups = List.from(popups);

    popups.sort((a, b) =>
        b.$1.createdAt.toDateTime().compareTo(a.$1.createdAt.toDateTime()));

    notifyListeners();
  }

  Future<void> invokeAction(int id, String action) async {
    WaylandMultiWindow.invokeMethod(
      0,
      SubWindowEvents.invokeAction.toString(),
      jsonEncode({"id": id, "action": action}),
    );
  }

  Future<void> sendCloseEvent(int id) async {
    WaylandMultiWindow.invokeMethod(
      0,
      SubWindowEvents.notificationClosed.toString(),
      jsonEncode({"id": id}),
    );
  }

  Timer schedulePopupCleanUp(int id, Timestamp date) {
    return Timer(const Duration(seconds: 5), () {
      closePopupWithDate(id, date);

      if (popups.isEmpty) {
        // TODO Understand why [PopupsList] does not resize automatically.
        if (isHidden) {
          layerController.hide();
          print("POPUP CLEAN UP HIDE WINDOW");
        }
      }
    });
  }

  void updateTimer(int id, Timer timer) {
    final index = popups.indexWhere((tuple) => tuple.$1.id == id);
    final tuple = popups[index];
    popups[index] = (tuple.$1, timer);
  }

  void closePopupWithDate(int id, Timestamp date) {
    popups = List.from(
        popups..removeWhere(((n) => n.$1.id == id && n.$1.createdAt == date)));
    notifyListeners();

    if (popups.isEmpty) {
      layerController.hide();
    }
  }

  void closePopup(int id) {
    popups = List.from(popups..removeWhere(((n) => n.$1.id == id)));
    notifyListeners();

    if (popups.isEmpty) {
      layerController.hide();
    }
  }

  void cancelClosePopupTimer(int id) {
    final timer = popups.firstWhere((tuple) => tuple.$1.id == id).$2;
    timer?.cancel();
  }

  Future<void> setLayerSize(Size size) async {
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    await layerController.setLayerSize(size);
  }
}
