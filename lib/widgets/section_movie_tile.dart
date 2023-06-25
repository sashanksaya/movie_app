import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';
import '../models/movie.dart';
import '../utils/constants.dart' as constants;

class SectionMovieTile extends StatelessWidget {
  const SectionMovieTile({
    super.key,
    required this.movieList,
    required this.i,
  });

  final List<Movie> movieList;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 150,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
          color: const Color(0xFF292B37),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF292B37).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              movieList[i].image,
              height: constants.movieTileHeight,
              width: constants.movieTileWidth,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  child: TextScroll(
                    movieList[i].title,
                    intervalSpaces: 10,
                    velocity: const Velocity(
                      pixelsPerSecond: Offset(
                        30,
                        0,
                      ),
                    ),
                    pauseBetween: const Duration(milliseconds: 2000),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                  child: TextScroll(
                    movieList[i].genre,
                    intervalSpaces: 10,
                    velocity: const Velocity(
                      pixelsPerSecond: Offset(
                        20,
                        0,
                      ),
                    ),
                    pauseBetween: const Duration(milliseconds: 2000),
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      movieList[i].rating.toString(),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
