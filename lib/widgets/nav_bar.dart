import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF292B37),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              //Navigate to Home Page
              Navigator.pushNamed(context, HomePage.routeName);
            },
            child: const Icon(
              Icons.home,
              size: 35,
              color: Colors.white,
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     //Navigate to Category Page
          //     Navigator.pushNamed(context, CategoryPage.routeName);
          //   },
          //   child: const Icon(
          //     Icons.category,
          //     size: 35,
          //     color: Colors.white,
          //   ),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: const Icon(
          //     Icons.favorite_border,
          //     size: 35,
          //     color: Colors.white,
          //   ),
          // ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.person,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
