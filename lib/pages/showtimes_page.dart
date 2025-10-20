import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';
import '../models/showtime.dart';
import '../providers/movies_provider.dart';

class ShowtimesPage extends StatelessWidget {
  const ShowtimesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int? movieId = ModalRoute.of(context)!.settings.arguments as int?;
    final moviesProv = context.watch<MoviesProvider>();

    final List<Map<String, dynamic>> entries = movieId == null
        ? moviesProv.movies
        .map((m) => {
      'movie': m.title,
      'items': moviesProv.showtimesFor(m.id),
      'id': m.id,
      'obj': m,
    })
        .toList()
        : [
      {
        'movie': moviesProv.byId(movieId)?.title ?? 'Nepoznat film',
        'items': moviesProv.showtimesFor(movieId),
        'id': movieId,
        'obj': moviesProv.byId(movieId),
      }
    ];

    Widget thumb(Movie m) => ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 56,
        height: 56,
        child: (m.posterAsset != null && m.posterAsset!.isNotEmpty)
            ? Image.asset(m.posterAsset!, fit: BoxFit.cover)
            : (m.posterUrl != null && m.posterUrl!.isNotEmpty)
            ? Image.network(m.posterUrl!, fit: BoxFit.cover)
            : Container(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: const Icon(Icons.local_movies),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Termini projekcija')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: entries.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final e = entries[index];
            final String title = e['movie'] as String;
            final int mid = e['id'] as int;
            final List<Showtime> list = e['items'] as List<Showtime>;
            final Movie? m = e['obj'] as Movie?;

            return ExpansionTile(
              leading: m == null
                  ? const Icon(Icons.movie_creation_outlined)
                  : Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: thumb(m),
              ),
              title: Text(title),
              children: list.isEmpty
                  ? const [ListTile(title: Text('Nema termina'))]
                  : list
                  .map(
                    (s) => ListTile(
                  leading: const Icon(Icons.theaters),
                  title: Text(s.hall),
                  subtitle: Text(s.times.join(', ')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/seats',
                    arguments: {
                      'movieId': mid,
                      'hall': s.hall,
                    },
                  ),
                ),
              )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
