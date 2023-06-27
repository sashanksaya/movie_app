import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/category_page.dart';
import 'package:movie_app/pages/profile_page.dart';

import 'home_page.dart';
import 'search_page.dart';

class WrapperPage extends StatefulWidget {
  static const routeName = '/wrapperPage';
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

int _currentIndex = 0;
final pages = [
  const HomePage(),
  const SearchPage(),
  const CategoryPage(),
  const ProfilePage(),
];

class _WrapperPageState extends State<WrapperPage> {
  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: DotNavigationBar(
        itemPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        margin: const EdgeInsets.all(1),
        backgroundColor: Colors.black,
        dotIndicatorColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(153, 143, 139, 139),
        currentIndex: _currentIndex,
        onTap: changePage,
        items: [
          DotNavigationBarItem(
            icon: const Icon(Icons.home),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.search),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.category),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.person),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
