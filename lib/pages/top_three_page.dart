import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../models/movie.dart';

class TopThreePage extends StatelessWidget {
  const TopThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProv = context.watch<MoviesProvider>();

    final List<Movie> top3 = (moviesProv.movies
        .where((m) => !m.comingSoon)
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating)))
        .take(3)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Top 3 po oceni')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: top3.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final m = top3[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            leading: Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 56, height: 56,
                    child: (m.posterAsset != null && m.posterAsset!.isNotEmpty)
                        ? Image.asset(m.posterAsset!, fit: BoxFit.cover)
                        : (m.posterUrl != null && m.posterUrl!.isNotEmpty)
                        ? Image.network(m.posterUrl!, fit: BoxFit.cover)
                        : Container(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: const Icon(Icons.local_movies),
                    ),
                  ),
                ),
                Positioned(
                  top: -6, left: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange, borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('#${index + 1}', style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            title: Text(m.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              children: [
                const Icon(Icons.star_rate, size: 18),
                const SizedBox(width: 4),
                Text(m.rating.toStringAsFixed(1)),
                const SizedBox(width: 12),
                Text('${m.genre} • ${m.durationMin} min'),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/details', arguments: m.id),
          );
        },
      ),
    );
  }
}
