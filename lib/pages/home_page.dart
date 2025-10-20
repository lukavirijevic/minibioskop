import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';
import '../providers/movies_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/movie_card.dart';
import '../models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;

  Future<void> _onTabChanged(int index) async {
    if (index == 1) {
      setState(() => _tabIndex = 1);
      await Navigator.pushNamed(context, '/wishlist');
      if (!mounted) return;
      setState(() => _tabIndex = 0);
    } else {
      setState(() => _tabIndex = 0);
    }
  }

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final moviesProv = context.watch<MoviesProvider>();
    final wish = context.watch<WishlistProvider>();

    final q = _query.toLowerCase().trim();
    final List<Movie> data = moviesProv.movies
        .where((m) => !m.comingSoon)
        .where((m) => m.title.toLowerCase().contains(q))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Bioskop'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/coming-soon'),
            child: const Text(
              'SOON',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          IconButton(
            tooltip: theme.isDark ? 'Svetla tema' : 'Tamna tema',
            icon: Icon(theme.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => theme.toggle(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pretraži filmove…',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Colors.deepOrange.withOpacity(0.85),
        child: SafeArea(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.favorite_outline, color: Colors.black),
                title: const Text('Omiljeni filmovi', style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/wishlist'),
              ),
              ListTile(
                leading: const Icon(Icons.schedule, color: Colors.black),
                title: const Text('Moje rezervacije', style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/reservations'),
              ),
              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.black),
                title: const Text('Projekcije', style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/showtimes'),
              ),
              ListTile(
                leading: const Icon(Icons.new_releases_outlined, color: Colors.black),
                title: const Text('Uskoro', style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/coming-soon'),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text('Podešavanja', style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.pushNamed(context, '/top-three'),
                child: Row(
                  children: [
                    Text('Top 3 po oceni', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      'Prikaži',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 96),
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.6,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final m = data[index];
                  final wished = wish.contains(m.id);
                  return MovieCard(
                    movie: m,
                    wished: wished,
                    onToggleWish: () {
                      context.read<WishlistProvider>().toggle(m.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(wished ? 'Uklonjeno iz omiljenih' : 'Dodato u omiljene')),
                      );
                    },
                    onTap: () => Navigator.pushNamed(context, '/details', arguments: m.id),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.deepOrange,
        selectedIndex: _tabIndex,
        onDestinationSelected: _onTabChanged,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Početna',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite, color: Colors.white),
            label: 'Omiljeni filmovi',
          ),
        ],
      ),

      floatingActionButton: SizedBox(
        width: 80,
        height: 60,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/showtimes'),
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: const Icon(Icons.schedule),
        ),
      ),
    );
  }
}
