import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';
import 'providers/movies_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/reservations_provider.dart';

import 'pages/home_page.dart';
import 'pages/details_page.dart';
import 'pages/showtimes_page.dart';
import 'pages/seats_page.dart';
import 'pages/wishlist_page.dart';
import 'pages/settings_page.dart';
import 'pages/reservation_page.dart';
import 'pages/coming_soon_page.dart';
import 'pages/top_three_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiniBioskopApp());
}


class MiniBioskopApp extends StatelessWidget {
  const MiniBioskopApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()..loadMock()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ReservationsProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: theme.mode,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomePage(),
            '/details': (context) => const DetailsPage(),
            '/showtimes': (context) => const ShowtimesPage(),
            '/seats': (context) => const SeatsPage(),
            '/wishlist': (context) => const WishlistPage(),
            '/settings': (context) => const SettingsPage(),
            '/reservations': (context) => const ReservationsPage(),
            '/coming-soon': (context) => const ComingSoonPage(),
            '/top-three': (context) => const TopThreePage(),
          },
        ),
      ),
    );
  }
}
