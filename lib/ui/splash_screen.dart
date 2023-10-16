import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myrestaurant/common/styles.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/ui/home_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash:
          // Lottie.asset('assets/lottie_animation.json'),
          Column(
        children: [
          Image.asset(
            'images/restaurant.png',
            width: 180,
          ),
          const Text(
            'My Restaurant',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      duration: 1200,
      splashIconSize: 279,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.theme,
      screenFunction: () async {
        final String json = await DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json');
        restaurants = Restaurant.parseRestaurants(json);
        return HomePage(restaurants: restaurants);
      },
      animationDuration: const Duration(milliseconds: 750),
    );
  }
}
