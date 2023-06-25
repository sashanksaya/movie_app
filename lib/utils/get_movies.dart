import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart' as constants;
import '../models/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Movie>> makeRequest(category) async {
  return getGenre().then(
    (genresMap) async {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/movie/$category?language=en-US&page=1&api_key=${dotenv.env['TMDB_API_KEY']}');
      try {
        final response = await http.get(url, headers: constants.headers);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final movies = jsonResponse['results'] as List<dynamic>;
          List<Movie> movieList = movies.map((movie) {
            final id = movie['id'];
            final title = movie['title'];
            final description = movie['overview'];
            final image =
                'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
            final rating = movie['vote_average'].toDouble();
            final genre = movie['genre_ids'];
            var genresDefined = [];
            for (int g = 0; g < genre.length; g++) {
              genresDefined.add(genresMap[genre[g]]);
            }
            return Movie(
              id: id,
              title: title,
              description: description,
              image: image,
              rating: rating,
              genre: genresDefined.join("/"),
            );
          }).toList();
          return movieList;
        } else {
          throw Exception(
              'Request failed with status: ${response.statusCode}.');
        }
      } catch (error) {
        throw Exception('Error: $error');
      }
    },
  );
}

Future<Map> getGenre() async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list?language=en&api_key=${dotenv.env['TMDB_API_KEY']}');
  try {
    final response = await http.get(url, headers: constants.headers);
    if (response.statusCode == 200) {
      final genresMap = json.decode(response.body)["genres"];
      var genres = {};
      for (int genre = 0; genre < genresMap.length; genre++) {
        genres[genresMap[genre]["id"]] = genresMap[genre]["name"];
      }
      return genres;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}
