import 'package:flutter/material.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/provider/search_provider.dart';
import 'package:myrestaurant/ui/detail_page.dart';
import 'package:myrestaurant/ui/home_page.dart';
import 'package:myrestaurant/ui/list_page.dart';
import 'package:myrestaurant/ui/search_page.dart';
import 'package:myrestaurant/ui/splash_screen.dart';
import 'package:provider/provider.dart';

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
        HomePage.routeName: (context) => const HomePage(),
        ListPage.routeName: (context) => const ListPage(),
        DetailPage.routeName: (context) => DetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        SearchPage.routeName: (context) => ChangeNotifierProvider(
              create: (context) => SearchProvider(
                apiService: ApiService(),
              ),
              child: const SearchPage(),
            ),
      },
    );
  }
}
