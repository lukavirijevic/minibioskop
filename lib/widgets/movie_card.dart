import 'package:flutter/material.dart';
import '../models/movie.dart';


class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onToggleWish;
  final bool wished;


  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onToggleWish,
    required this.wished,
  });

  Widget _poster(BuildContext context) {
    if (movie.posterAsset != null) {
      return Image.asset(
        movie.posterAsset!,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => _placeholder(context),
      );
    }
    return _placeholder(context);
  }

  Widget _placeholder(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.surfaceVariant,
    child: const Center(child: Icon(Icons.local_movies, size: 48)),
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 10 / 9,
              child: _poster(context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        color: Colors.deepOrange,
                        onPressed: onToggleWish,
                        icon: Icon(wished ? Icons.favorite : Icons.favorite_border),
                        tooltip: wished ? 'Ukloni iz želja' : 'Dodaj u želje',
                      ),
                    ],
                  ),
                  Text(
                      '${movie.genre} • ${movie.durationMin} min',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rate, size: 18),
                      const SizedBox(width: 4),
                      Text(movie.rating.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ),],
        ),
      ),
    );
  }
}