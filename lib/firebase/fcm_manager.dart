import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/backend/services/fcm_service/fcm_service.dart';
import 'package:shopping_app/injector.dart';
import 'package:shopping_app/storage/storages/fcm_token_storage.dart';

import 'fcm_payload.dart';

@lazySingleton
class FCMManager {
  static const String fcmBackgroundMessagePortName = "fcm_background_message";
  final _fbMessaging = FirebaseMessaging();
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FCMManager() {
    _initNotification();
    _setupFcmBackgroundMessageReceiver();
  }

  void _initNotification() {
    const initializationSettingsAndroid = AndroidInitializationSettings('logo');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (json) async => _onMessage(FCMPayload.fromJson(json)));
  }

  void _setupFcmBackgroundMessageReceiver() {
    final ReceivePort receivePort = ReceivePort();
    final SendPort sendPort = receivePort.sendPort;
    IsolateNameServer.registerPortWithName(sendPort, fcmBackgroundMessagePortName);
    receivePort.listen((message) {
      return _onMessage(FCMPayload.create(message as Map<String, dynamic>));
    });
  }

  static Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) {
    final SendPort sendPort = IsolateNameServer.lookupPortByName(fcmBackgroundMessagePortName);
    sendPort.send(message);
    return Future.value();
  }

  void _pushNotification(FCMPayload payload) {
    // injector<BadgerHelper>().updateBadgeCount();
    final bigTextStyleInformation = BigTextStyleInformation(payload.body);
    final androidPlatformChannelSpecifics = AndroidNotificationDetails('global_channel', 'Global notifications', 'All of notifications',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker', vibrationPattern: Int64List.fromList([0, 500]), styleInformation: bigTextStyleInformation);
    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(0, payload.title, payload.body, platformChannelSpecifics, payload: payload.toJson());
  }

  void configNotification(BuildContext context) {
    _fbMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final payload = FCMPayload.create(message);
        debugPrint("FCM On Message - Payload ${payload.toJson()}");
        if (payload.isDataMessage) {
          await _onMessage(payload);
        } else {
          _pushNotification(payload);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint("ONLAUNCH");
        await _onMessage(FCMPayload.create(message));
      },
      onResume: (Map<String, dynamic> message) async {
        debugPrint("ONRESUME");
        await _onMessage(FCMPayload.create(message));
      },
      onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
    );
    _fbMessaging.requestNotificationPermissions(const IosNotificationSettings(provisional: true));
    _fbMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {});
  }

  Future<void> _onMessage(FCMPayload payload) async {
    debugPrint("FCM On Message - Payload ${payload.toJson()}");
    // if (await injector<Oauth2Manager>().isLoggedIn()) {
    //   try {
    //     await FirebaseService(baseUrl: Config.CURRENT_URL).readNotification((payload.data['item_id'] as int).toString());
    //     // ignore: empty_catches
    //   } catch (ex) {}
    //
    //   fcmMessageHandlerRoutes[payload.type]?.handle(payload);
    // }
  }

  Future<void> registerFcmToken() async {
    final String fcmToken = injector<FCMTokenStorage>().get();
    debugPrint("- FCM Token: $fcmToken");
    if (fcmToken?.isNotEmpty == true) {
      return;
    }
    final String token = await _fbMessaging.getToken();
    assert(token != null);
    debugPrint("- FCM Token: $token");
    await injector<FCMService>().registerFCM(token);
    injector<FCMTokenStorage>().set(token);
  }
}
