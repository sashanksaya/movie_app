import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/section_movie_tile.dart';
import '../utils/get_movies.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

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
                "Now Playing",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Movie>>(
            future: makeRequest("now_playing"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movieList = snapshot.data!;
                return Row(
                  children: [
                    for (int movie = 0; movie < movieList.length; movie++)
                      SectionMovieTile(
                        movieList: movieList,
                        i: movie,
                        category: "now_playing",
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
        ),
      ],
    );
  }
}
