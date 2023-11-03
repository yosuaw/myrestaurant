import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myrestaurant/common/navigation.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/data/db/database_helper.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/data/preferences/preferences_helper.dart';
import 'package:myrestaurant/provider/database_provider.dart';
import 'package:myrestaurant/provider/preferences_provider.dart';
import 'package:myrestaurant/provider/restaurant_review_provider.dart';
import 'package:myrestaurant/provider/restaurant_list_provider.dart';
import 'package:myrestaurant/provider/scheduling_provider.dart';
import 'package:myrestaurant/provider/search_provider.dart';
import 'package:myrestaurant/ui/detail_page.dart';
import 'package:myrestaurant/ui/home_page.dart';
import 'package:myrestaurant/ui/review_page.dart';
import 'package:myrestaurant/ui/search_page.dart';
import 'package:myrestaurant/ui/splash_screen.dart';
import 'package:myrestaurant/utils/background_service.dart';
import 'package:myrestaurant/utils/notification_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final BackgroundService service = BackgroundService();
  final NotificationHelper notificationHelper = NotificationHelper();

  await Permission.notification.isDenied
      .then((value) => Permission.notification.request());

  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantReviewProvider(
            apiService: ApiService(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'My Restaurant',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          textTheme: myTextTheme,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
                background: backgroundColor,
              ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: secondaryColor,
          //     foregroundColor: Colors.white,
          //     textStyle: const TextStyle(),
          //     shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(0)),
          //     ),
          //   ),
          // ),
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchPage.routeName: (context) => ChangeNotifierProvider(
                create: (context) => SearchProvider(
                  apiService: ApiService(),
                ),
                child: const SearchPage(),
              ),
          ReviewPage.routeName: (context) => ReviewPage(
              id: ModalRoute.of(context)?.settings.arguments as String),
        },
      ),
    );
  }
}
