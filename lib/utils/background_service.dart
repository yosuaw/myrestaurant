import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/main.dart';
import 'package:myrestaurant/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var restaurantsResult = await ApiService().listRestaurants();
    int randIdx = Random().nextInt(restaurantsResult.restaurants.length);
    var titleRestaurant = restaurantsResult.restaurants[randIdx].name;

    var result = await ApiService().detailRestaurant(restaurantsResult.restaurants[randIdx].id);
    final restaurant = result.restaurants.first;

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, titleRestaurant, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
