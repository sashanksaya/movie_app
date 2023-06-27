import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/pages/profile_page.dart';
import 'package:movie_app/pages/wrapper_page.dart';
import '../pages/movie_detail_page.dart';
import '../pages/home_page.dart';

import 'pages/category_page.dart';
import 'pages/search_page.dart';

void main() async {
  await dotenv.load();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      routes: {
        WrapperPage.routeName: (context) => const WrapperPage(),
        HomePage.routeName: (context) => const HomePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        MovieDetailPage.routeName: (context) => const MovieDetailPage(),
      },
      home: const WrapperPage(),
    );
  }
}
