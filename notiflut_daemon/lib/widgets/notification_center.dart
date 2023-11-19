import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:notiflutland/messages/daemon_event.pb.dart' as daemon_event
    show Notification;
import 'package:notiflutland/widgets/mediaPlayer.dart';

import '../services/mainwindow_service.dart';
import '../utils.dart';
import 'category.dart';
import 'notification.dart';

class NotificationCenter extends StatefulWidget with GetItStatefulWidgetMixin {
  NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter>
    with GetItStateMixin {
  Timer? notificationUpTimeTimer;

  @override
  void dispose() {
    notificationUpTimeTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    notificationUpTimeTimer =
        Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifications = watchOnly((MainWindowService s) => s.notifications);
    final notificationByCategory = notifications
        .fold(<String, List<daemon_event.Notification>>{}, (map, notification) {
      final key = notification.appName;

      map.putIfAbsent(key, () => []);
      map[key]!.add(notification);
      return map;
    });

    final keys = notificationByCategory.keys;
    final categoryWidgets = keys.map((e) {
      final notifications = notificationByCategory[e]!;

      final notificationTiles = notifications.map((n) {
        ImageProvider<Object>? imageProvider = imageRawToProvider(n.appImage);
        ImageProvider<Object>? iconeProvider = imageRawToProvider(n.appIcon);
        return NotificationTile(
          n.id,
          n.appName,
          n.summary,
          n.body,
          iconProvider: iconeProvider,
          imageProvider: imageProvider,
          createdAt: n.createdAt.toDateTime(),
          actions: actionsListToMap(n.actions)
              .where((element) => element.$1 != "default")
              .map((e) => NotificationAction(e.$2, () {
                    get<MainWindowService>().invokeAction(n.id, e.$1);
                    get<MainWindowService>().closeNotification(n.id);
                  }))
              .toList(),
          onTileTap: () {
            get<MainWindowService>().invokeAction(n.id, "default");
            get<MainWindowService>().closeNotification(n.id);
          },
          closeAction: () {
            get<MainWindowService>().closeNotification(n.id);
          },
        );
      }).toList();

      return NotificationCategory(
        key: Key(e),
        appName: e,
        children: notificationTiles,
      );
    }).toList();

    // TODO find why there is a warning on runtime
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          height: double.infinity,
          color: Colors.transparent,
          child: ListView(
            children: [MediaPlayer(), ...categoryWidgets],
          ),
        ),
      ],
    );
  }
}
