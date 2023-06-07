// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.75.1.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;

part 'bridge_definitions.freezed.dart';

abstract class Native {
  /// This needs to be called first
  Future<void> setup({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSetupConstMeta;

  /// Starts the daemon
  /// This can fail if setup was not called before
  Stream<DaemonAction> startDaemon({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kStartDaemonConstMeta;

  /// Stop the daemon
  Future<void> stopDaemon({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kStopDaemonConstMeta;

  /// Sends an event to rust code
  Future<void> sendDaemonAction({required DaemonAction action, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kSendDaemonActionConstMeta;
}

@freezed
class DaemonAction with _$DaemonAction {
  const factory DaemonAction.show(
    Notification field0,
  ) = DaemonAction_Show;
  const factory DaemonAction.showNc() = DaemonAction_ShowNc;
  const factory DaemonAction.closeNc() = DaemonAction_CloseNc;
  const factory DaemonAction.close(
    int field0,
  ) = DaemonAction_Close;
  const factory DaemonAction.update(
    List<Notification> field0, [
    int? field1,
  ]) = DaemonAction_Update;
  const factory DaemonAction.flutterClose(
    int field0,
  ) = DaemonAction_FlutterClose;
  const factory DaemonAction.flutterCloseAll() = DaemonAction_FlutterCloseAll;
  const factory DaemonAction.flutterActionInvoked(
    int field0,
    String field1,
  ) = DaemonAction_FlutterActionInvoked;
}

class Hints {
  final bool? actionsIcon;
  final String? category;
  final String? desktopEntry;
  final bool? resident;
  final String? soundFile;
  final String? soundName;
  final bool? suppressSound;
  final bool? transient;
  final int? x;
  final int? y;
  final Urgency? urgency;

  const Hints({
    this.actionsIcon,
    this.category,
    this.desktopEntry,
    this.resident,
    this.soundFile,
    this.soundName,
    this.suppressSound,
    this.transient,
    this.x,
    this.y,
    this.urgency,
  });
}

class ImageData {
  final int width;
  final int height;
  final int rowstride;
  final bool onePointTwoBitAlpha;
  final int bitsPerSample;
  final int channels;
  final Uint8List data;

  const ImageData({
    required this.width,
    required this.height,
    required this.rowstride,
    required this.onePointTwoBitAlpha,
    required this.bitsPerSample,
    required this.channels,
    required this.data,
  });
}

@freezed
class ImageSource with _$ImageSource {
  const factory ImageSource.data(
    ImageData field0,
  ) = ImageSource_Data;
  const factory ImageSource.path(
    String field0,
  ) = ImageSource_Path;
}

class Notification {
  final int id;
  final String appName;
  final int replacesId;
  final String summary;
  final String body;
  final List<String> actions;
  final int timeout;
  final DateTime createdAt;
  final Hints hints;
  final ImageSource? appIcon;
  final ImageSource? appImage;

  const Notification({
    required this.id,
    required this.appName,
    required this.replacesId,
    required this.summary,
    required this.body,
    required this.actions,
    required this.timeout,
    required this.createdAt,
    required this.hints,
    this.appIcon,
    this.appImage,
  });
}

enum Urgency {
  Low,
  Normal,
  Critical,
}
