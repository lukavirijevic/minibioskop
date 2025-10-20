import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../providers/reservations_provider.dart';
import '../models/reservation.dart';

class SeatsPage extends StatelessWidget {
  const SeatsPage({super.key});

  static const int rows = 6;
  static const int cols = 8;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final moviesProv = context.watch<MoviesProvider>();

    final int movieId = (args?['movieId'] as int?) ?? moviesProv.movies.first.id;
    final String hall = (args?['hall'] as String?) ??
        (moviesProv.showtimesFor(movieId).isNotEmpty
            ? moviesProv.showtimesFor(movieId).first.hall
            : 'Sala 1');

    final movie = moviesProv.byId(movieId) ?? moviesProv.movies.first;
    final times = moviesProv
        .showtimesFor(movieId)
        .where((s) => s.hall == hall)
        .expand((s) => s.times)
        .toList();

    return Scaffold(
        appBar: AppBar(title: Text('Sedišta • ${movie.title} • $hall')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            children: [

              Container(
                height: 10,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade400,
                  borderRadius: BorderRadius.circular(6),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                final r = index ~/ cols;
                final c = index % cols;
                final reserved = (r == 2 && c % 2 == 0) || (r == 4 && c % 3 == 0);
                return IgnorePointer(
                  ignoring: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: reserved
                      ? Theme.of(context).disabledColor.withOpacity(0.35)
                      : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Theme.of(context).dividerColor),
                ),
                ),
              );
            },
            ),
            const SizedBox(height: 20),

              Text('Odaberi termin', style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 6),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: times.isEmpty
                ? [const Chip(label: Text('Nema termina'))]
                : times.map((t) {
                  return FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepOrange.shade400,
                        foregroundColor: Colors.white),
                      onPressed: () {
                        final reservation = Reservation(
                          movieId: movieId,
                          movieTitle: movie.title,
                          hall: hall,
                          time: t,
                          createdAt: DateTime.now(),
                          );
                          context.read<ReservationsProvider>().add(reservation);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sačuvano: ${movie.title} • $hall • $t')),
                      );
                      },
                      child: Text(t),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 12),
          

                Align(
                  alignment: Alignment.center,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepOrange),
                    onPressed: () => Navigator.pushNamed(context, '/reservations'),
                    icon: const Icon(Icons.list_alt),
                    label: const Text('Moje rezervacije'),
                  ),
                ),
              ],
            ),
        ),
      );
    }
  }