import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../pages/movie_detail_page.dart';
import '../utils/constants.dart' as constants;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key});

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
                "Upcoming Movies",
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
            future: makeRequest(),
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
                            arguments: {
                              'movie': movieList[i],
                              'category': 'upcoming'
                            },
                          );
                        },
                        child: Hero(
                          tag: '${movieList[i].id}upcoming',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                movieList[i].image,
                                height: 220,
                                width: 150,
                                fit: BoxFit.fitHeight,
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

Future<List<Movie>> makeRequest() async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&api_key=${dotenv.env['TMDB_API_KEY']}');

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
        final backdropPath =
            'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';
        return Movie(
          id: id,
          title: title,
          description: description,
          image: image,
          backdropPath: backdropPath,
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
