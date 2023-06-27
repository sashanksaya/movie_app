import 'package:flutter/material.dart';
import '../sections/popular_section.dart';
import '../sections/top_rated_section.dart';
import '../sections/upcoming_section.dart';
import '../sections/now_playing_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = "/homePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(137, 34, 34, 34),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Hamilton!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "What to watch?",
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "images/profile.jpg",
                    height: 60,
                    width: 60,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const UpcomingSection(),
          const SizedBox(height: 20),
          const NowPlayingSection(),
          const SizedBox(height: 20),
          const TopRatedSection(),
          const SizedBox(height: 20),
          const PopularSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
