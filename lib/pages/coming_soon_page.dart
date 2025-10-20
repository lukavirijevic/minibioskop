import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movies_provider.dart';
import '../widgets/coming_soon_card.dart';
import '../models/movie.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.watch<MoviesProvider>().movies
        .where((m) => m.comingSoon)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Uskoro na velikom platnu')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.66,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final Movie m = movies[index];
            return ComingSoonCard(
              movie: m,
              onTap: () => Navigator.pushNamed(context, '/details', arguments: m.id),
            );
          },
        ),
      ),
    );
  }
}
