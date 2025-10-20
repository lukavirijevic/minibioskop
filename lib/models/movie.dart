class Movie {
  final int id;
  final String title;
  final String genre;
  final int durationMin;
  final double rating;
  final String description;
  final String? posterAsset;
  final String? posterUrl;
  final String director;
  final List<String> cast;
  final bool comingSoon;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.durationMin,
    required this.rating,
    required this.description,
    this.posterAsset,
    this.posterUrl,
    this.director = '',
    this.cast = const [],
    this.comingSoon = false
  });
}