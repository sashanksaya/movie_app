class Movie {
  final int id;
  final String title;
  final String description;
  final String image;
  final double rating;
  final String genre;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.rating = 0.0,
    this.genre = '',
  });
}
