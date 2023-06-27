import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../sections/recommend_section.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  static const routeName = '/moviePage';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final movie = args['movie']! as Movie;
    final category = args['category']!;

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.network(
              movie.backdropPath,
              height: 280,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: movie.id.toString() + category.toString(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 58, 55, 55)
                                        .withOpacity(0.6),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                movie.image,
                                height: 250,
                                width: 180,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 50, top: 80),
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color.fromARGB(253, 43, 53, 80),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 182, 178, 178)
                                    .withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          movie.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RecommendSection(movieId: movie.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
