import 'package:flutter/material.dart';
import 'package:myrestaurant/data/api/api_service.dart';
import 'package:myrestaurant/provider/restaurant_list_provider.dart';
import 'package:myrestaurant/ui/list_page.dart';
import 'package:myrestaurant/ui/profile_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

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

  final List<Widget> _getWidget = [
    ChangeNotifierProvider<RestaurantListProvider>(
      create: (context) => RestaurantListProvider(apiService: ApiService()),
      child: const ListPage(),
    ),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getWidget[_bottomNavIndex],
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
