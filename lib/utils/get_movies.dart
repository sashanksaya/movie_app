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
            final genre = movie['genre_ids'];
            var genresDefined = [];
            for (int g = 0; g < genre.length; g++) {
              genresDefined.add(genresMap[genre[g]]);
            }
            return Movie(
              id: movie['id'],
              title: movie['title'],
              description: movie['overview'],
              image: movie['poster_path'] != null
                  ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                  : "https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Poster.png",
              backdropPath: movie['backdrop_path'] != null
                  ? 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'
                  : "https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Profile.jpg",
              rating: movie['vote_average'].toDouble(),
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

Future<List<Movie>> getRecommendedMovies(int movieId) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/recommendations?language=en-US&page=1&api_key=${dotenv.env['TMDB_API_KEY']}');

  try {
    final response = await http.get(url, headers: constants.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'] as List<dynamic>;
      return getMoviesList(movies);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

Future<List<Movie>> getSearchedMovie(String movieName) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?query=$movieName&include_adult=false&language=en-US&page=1&api_key=${dotenv.env['TMDB_API_KEY']}');
  try {
    final response = await http.get(url, headers: constants.headers);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'] as List<dynamic>;
      return getMoviesList(movies);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    throw Exception('Error: $error');
  }
}

List<Movie> getMoviesList(List<dynamic> movies) {
  return movies.map((movie) {
    return Movie(
      id: movie['id'],
      title: movie['title'],
      image: movie['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
          : "https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Poster.png",
      backdropPath: movie['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'
          : "https://www.indieactivity.com/wp-content/uploads/2022/03/File-Not-Found-Profile.jpg",
      rating: movie['vote_average'].toDouble() ?? 0.0,
      description: movie['overview'] ?? " ",
    );
  }).toList();
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
