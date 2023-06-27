class Movie {
  final int id;
  final String title;
  final String description;
  final String image;
  final String backdropPath;
  final double rating;
  final String genre;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.backdropPath,
    this.rating = 0.0,
    this.genre = '',
  });
}
