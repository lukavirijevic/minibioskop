class Reservation {
  final int movieId;
  final String movieTitle;
  final String hall;
  final String time;
  final DateTime createdAt;

  const Reservation({
    required this.movieId,
    required this.movieTitle,
    required this.hall,
    required this.time,
    required this.createdAt,
  });
}