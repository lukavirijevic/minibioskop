import 'package:flutter/material.dart';
import '../models/movie.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const ComingSoonCard({super.key, required this.movie, required this.onTap});

  Widget _poster(BuildContext context) {
    if (movie.posterAsset != null && movie.posterAsset!.isNotEmpty) {
      return Image.asset(movie.posterAsset!, fit: BoxFit.cover, width: double.infinity);
    }
    if (movie.posterUrl != null && movie.posterUrl!.isNotEmpty) {
      return Image.network(movie.posterUrl!, fit: BoxFit.cover, width: double.infinity);
    }
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const Center(child: Icon(Icons.local_movies, size: 48)),
    );
  }

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
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                      '${movie.genre} • ${movie.durationMin} min',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.new_releases_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text('USKORO', style: Theme.of(context).textTheme.bodySmall),
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
