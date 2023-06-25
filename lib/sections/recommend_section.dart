import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/movie_detail_page.dart';
import '../models/movie.dart';
import '../utils/constants.dart' as constants;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<Movie>>(
            future: makeRequest(movieId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movieList = snapshot.data!;
                return Row(
                  children: [
                    for (int i = 0; i < movieList.length; i++)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailPage.routeName,
                            arguments: movieList[i],
                          );
                        },
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

Future<List<Movie>> makeRequest(int movieId) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/recommendations?language=en-US&page=1&api_key=${dotenv.env['TMDB_API_KEY']}');

  try {
    final response = await http.get(url, headers: constants.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'] as List<dynamic>;
      List<Movie> movieList = movies.map((movie) {
        final id = movie['id'];
        final title = movie['title'];
        final description = movie['overview'];
        final image = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
        return Movie(
          id: id,
          title: title,
          description: description,
          image: image,
        );
      }).toList();
      return movieList;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}
