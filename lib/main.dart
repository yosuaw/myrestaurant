import 'package:flutter/material.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/ui/detail_page.dart';
import 'package:myrestaurant/ui/list_page.dart';
import 'package:myrestaurant/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Restaurant',
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
        ListPage.routeName: (context) => ListPage(
              restaurants: ModalRoute.of(context)?.settings.arguments
                  as List<Restaurant>,
            ),
        DetailPage.routeName: (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
