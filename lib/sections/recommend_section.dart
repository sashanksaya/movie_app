import 'package:flutter/material.dart';
import 'package:movie_app/utils/get_movies.dart';
import '../pages/movie_detail_page.dart';
import '../models/movie.dart';

class RecommendSection extends StatelessWidget {
  final int movieId;
  const RecommendSection({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Movie>>(
            future: getRecommendedMovies(movieId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movieList = snapshot.data!;
                return Row(
                  children: [
                    for (int i = 0; i < movieList.length; i++)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MovieDetailPage.routeName,
                              arguments: {
                                'movie': movieList[i],
                                'category': 'recommended',
                              });
                        },
                        child: Hero(
                          tag: '${movieList[i].id}recommended',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                movieList[i].image,
                                height: 220,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
