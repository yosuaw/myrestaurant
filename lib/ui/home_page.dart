import 'package:flutter/material.dart';
import 'package:myrestaurant/data/model/restaurant.dart';
import 'package:myrestaurant/ui/list_page.dart';
import 'package:myrestaurant/ui/profile_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  final List<Restaurant> restaurants;

  const HomePage({super.key, required this.restaurants});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
  ];

  Widget _getWidget(int navIndex) {
    switch (navIndex) {
      case 0:
        return ListPage(restaurants: widget.restaurants);
      case 1:
        return const ProfilePage();
      default:
        return ListPage(restaurants: widget.restaurants);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getWidget(_bottomNavIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
      ),
    );
  }
}
