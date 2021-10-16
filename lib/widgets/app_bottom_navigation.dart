import 'package:api_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AppBottomNavigation extends StatefulWidget {
  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  int _selectedIndex = 0;
  List<dynamic> menuItems = [
    {
      'icon': 'assets/icons/home.svg',
      'label': 'Home',
    },
    {
      'icon': 'assets/icons/favorite.svg',
      'label': 'Favorite',
    },
    {
      'icon': 'assets/icons/desk.svg',
      'label': 'Video',
    },
    {
      'icon': 'assets/icons/profile.svg',
      'label': 'Profile',
    },
    {
      'icon': 'assets/icons/sort.svg',
      'label': 'Refresh',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.black87,
      elevation: 32.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        height: 1.5,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        height: 1.5,
        fontSize: 12,
      ),
      items: menuItems.map((i) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(i['icon']),
          activeIcon: SvgPicture.asset(
            i['icon'],
            color: primaryColor,
          ),
          label: i['label'],
        );
      }).toList(),
      currentIndex: 0,
      selectedItemColor: primaryColor,
      onTap: _onItemTapped,
    );
  }
}