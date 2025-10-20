import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../providers/movies_provider.dart';
import '../models/movie.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wish = context.watch<WishlistProvider>();
    final movies = context.watch<MoviesProvider>().movies;
    final items = movies.where((m) => wish.contains(m.id)).toList();

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
        appBar: AppBar(title: const Text('Omiljeni filmovi')),
        body: items.isEmpty
          ? const Center(child: Text('Nema filmova među omiljenim.'))
          : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final m = items[index];
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
                title: Text(m.title),
                subtitle: Text('${m.genre} • ${m.durationMin} min'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.deepOrange,),
                  onPressed: () => context.read<WishlistProvider>().toggle(m.id),
                  ),
                onTap: () => Navigator.pushNamed(context, '/details', arguments: m.id),
                );
               },
              ),
        bottomNavigationBar: items.isEmpty
          ? null
          : Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white),
              onPressed: () => context.read<WishlistProvider>().clear(),
              child: const Text('Očisti omiljene filmove', style: TextStyle(fontSize: 16),),
            ),
          ),
        );
      }
    }