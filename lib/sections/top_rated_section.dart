import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../pages/movie_detail_page.dart';
import '../widgets/section_movie_tile.dart';
import '../utils/get_movies.dart' as get_movies;

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({super.key});

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
                "Top Rated",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Text(
              //   "See All",
              //   style: TextStyle(
              //     color: Colors.white54,
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Movie>>(
            future: get_movies.makeRequest("top_rated"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movieList = snapshot.data!;
                return Row(
                  children: [
                    for (int movie = 0; movie < movieList.length; movie++)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailPage.routeName,
                            arguments: movieList[movie],
                          );
                        },
                        child: SectionMovieTile(
                          movieList: movieList,
                          i: movie,
                        ),
                      ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    );
  }
}
