import 'package:flutter/material.dart';
import 'package:navi_stream/features/presentation/pages/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  static var _selectedIndex = 0;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _onItemTapped(int index) {
    setState(
      () {
        CustomBottomNavigationBar._selectedIndex = index;
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: CustomBottomNavigationBar._selectedIndex,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        items('home_icon', 0),
        items('explore_icon', 1),
        items('favourites_icon', 2),
        items('profile_icon', 3),
      ],
      onTap: _onItemTapped,
    );
  }

  BottomNavigationBarItem items(String assetIcon, int index) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          'assets/bottom_navigation_bar_icons/$assetIcon.png',
          color: CustomBottomNavigationBar._selectedIndex == index
              ? const Color(0xFF887EF1)
              : const Color(0xFF515257),
        ),
        label: '');
  }
}
