import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../pages/movie_detail_page.dart';
import '../pages/home_page.dart';

import 'pages/category_page.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        MovieDetailPage.routeName: (context) => const MovieDetailPage(),
      },
    );
  }
}
