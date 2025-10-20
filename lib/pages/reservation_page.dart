import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservations_provider.dart';
import '../providers/movies_provider.dart';
import '../models/reservation.dart';
import '../models/movie.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ReservationsProvider>();
    final items = prov.items;
    final moviesProv = context.watch<MoviesProvider>();

    Widget thumb(Movie? m) {
      final placeholder = Container(
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: const Center(child: Icon(Icons.local_movies)),
      );

      if (m == null) return placeholder;

      Widget img;
      if (m.posterAsset != null && m.posterAsset!.isNotEmpty) {
        img = Image.asset(m.posterAsset!, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => placeholder);
      } else if (m.posterUrl != null && m.posterUrl!.isNotEmpty) {
        img = Image.network(
          m.posterUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorBuilder: (context, error, stackTrace) => placeholder,
        );
      } else {
        img = placeholder;
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(width: 56, height: 56, child: img),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Moje rezervacije')),
      body: items.isEmpty
          ? const Center(child: Text('Nema sačuvanih rezervacija.'))
          : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final Reservation r = items[index];
              final subtitle = '${r.hall} • ${r.time}';
              final Movie? m = moviesProv.byId(r.movieId);

              return ListTile(
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: thumb(m),
                ),
                title: Text(r.movieTitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                subtitle: Text(subtitle),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.deepOrange),
                  onPressed: () => context.read<ReservationsProvider>().removeAt(index),
                  tooltip: 'Obriši',
                ),
                onTap: () => Navigator.pushNamed(context, '/details', arguments: r.movieId),
              );
        },
      ),
        bottomNavigationBar: items.isEmpty
            ? null
            : Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: FilledButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white),
              onPressed: () => context.read<ReservationsProvider>().clear(),
                child: const Text('Obriši sve'),
          ),
        )
    );
  }
}
