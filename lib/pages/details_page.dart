import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../providers/wishlist_provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int? ?? 1;
    final moviesProv = context.watch<MoviesProvider>();
    final movie = moviesProv.movies.firstWhere(
          (m) => m.id == id,
      orElse: () => moviesProv.movies.first,
    );
    final wished = context.watch<WishlistProvider>().contains(id);

    Widget poster() {
      if (movie.posterAsset != null && movie.posterAsset!.isNotEmpty) {
        return Image.asset(
          movie.posterAsset!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _placeholder(context),
        );
      }
      if (movie.posterUrl != null && movie.posterUrl!.isNotEmpty) {
        return Image.network(
          movie.posterUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) =>
          progress == null ? child : const Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) => _placeholder(context),
        );
      }
      return _placeholder(context);
    }

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            AspectRatio(
              aspectRatio: 10 / 12,
              child: poster(),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Chip(label: Text(movie.genre)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.schedule, size: 18),
                    SizedBox(width: 4),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 0),
                    Text('${movie.durationMin} min'),
                  ],
                ),
                if (!movie.comingSoon)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rate, size: 18),
                      const SizedBox(width: 4),
                      Text(movie.rating.toStringAsFixed(1)),
                    ],
                  ),
                if (movie.comingSoon)
                  const Chip(
                    avatar: Icon(Icons.new_releases_outlined, size: 18),
                    label: Text('Uskoro'),
                  ),
              ],
            ),

            const SizedBox(height: 12),
            Text(movie.description),
            const SizedBox(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_outline),
              title: const Text('Režiser'),
              subtitle: Text(
                (movie.director.isNotEmpty) ? movie.director : 'Nepoznato',
              ),
            ),

            const SizedBox(height: 4),
            Text('Glavne uloge', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (movie.cast.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: movie.cast
                    .map(
                      (name) => Chip(
                    label: Text(name),
                    avatar: const CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      radius: 10,
                      child: Icon(Icons.person, size: 14, color: Colors.white,),
                    ),
                  ),
                )
                    .toList(),
              )
            else
              const Text('Nema podataka'),

            const SizedBox(height: 16),

            if (!movie.comingSoon)
              Row(
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade400,
                    foregroundColor: Colors.white),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/showtimes',
                      arguments: movie.id,
                    ),
                    icon: const Icon(Icons.schedule),
                    label: const Text('Odaberi projekciju'),
                  ),
                  const SizedBox(width: 24),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.read<WishlistProvider>().toggle(movie.id),
                    icon: Icon(
                      wished ? Icons.favorite : Icons.favorite_border, color: Colors.deepOrange,
                    ),
                    label: Text(wished ? 'Ukloni želju' : 'Dodaj želju', style: TextStyle(color: Colors.deepOrange),),
                  ),
                ],
              ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) => Container(
    color: Theme.of(context).colorScheme.surfaceVariant,
    child: const Center(child: Icon(Icons.local_movies, size: 80)),
  );
}

