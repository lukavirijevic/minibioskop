# Minibioskop

A demo mobile app for browsing movies, viewing showtimes, and saving simple reservations — no backend, all in-memory. Built with Flutter (Dart), Material 3 and Provider/ChangeNotifier state management.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Features**

- Home: search + movie grid (excludes ,,Coming Soon'' items), Top 3 by rating link, FAB to Showtimes.

- Movie Details: poster, genre, duration, (rating if not ,,Coming Soon''), director, cast, add/remove to Wishlist.

- Showtimes: grouped by movie, halls and time slots; mini poster thumbnail in list items.

- Seats: visual seat layout (non-interactive) with time buttons below ⇒ saves a My Reservation entry (movie + hall + time).

- My Reservations: list of saved entries (mini poster + delete one/all).

- Wishlist: add/remove movies (mini posters, clear all).

- Coming Soon: dedicated page with upcoming titles (no rating, no reservation).

- Top 3: three top-rated movies (excludes ,,Coming Soo'').

- Settings: light/dark theme toggle (ThemeMode).

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Screens**

- Home – search, ,,Top '' link, movie grid (excluding Coming Soon), FAB to showtimes, Drawer + NavigationBar.

- Details – poster, metadata, overview, director, cast (chips), actions (showtimes / wishlist).

- Showtimes – per-movie list (ExpansionTile) → hall + times; tap navigates to Seats.

- Seats – seat grid (visual only), time buttons below; tap saves to My Reservations.

- Wishlist – saved movies (mini poster, genre, duration); delete/clear.

- Reservations – saved entries (mini poster, movie, hall, time); delete one/all.

- Coming Soon – upcoming titles only (no ratings/reservations).

- Top Three – three highest-rated titles (sorted).

- Settings – theme switch and version info.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Tech & Architecture**

- Flutter (Dart)

- Material 3 (ThemeData, M3 widgets: AppBar, NavigationBar, Drawer, Card, Chip, Filled/Outlined Buttons, FAB…)

- Provider/ChangeNotifier state:

- ThemeProvider – light/dark

- MoviesProvider – movies & showtimes (mock data)

- WishlistProvider – movie IDs in wishlist

- ReservationsProvider – reservations (movie/hall/time)

- Navigation: named routes (Navigator.pushNamed)

- Images: Image.asset

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Project Structure**

```
lib/
--main.dart
--pages/
----home_page.dart
----details_page.dart
----showtimes_page.dart
----seats_page.dart
----wishlist_page.dart
----reservations_page.dart
----coming_soon_page.dart
----top_three_page.dart
----settings_page.dart
--models/
----movie.dart
----showtime.dart
----reservation.dart
--providers/
----movies_provider.dart
----wishlist_provider.dart
----reservations_provider.dart
--theme/
----theme_provider.dart
--widgets/
----movie_card.dart
----coming_soon_card.dart  
--images/ ...     
```

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Data Models**

- Movie: id, title, genre, durationMin, rating, description, posterAsset/posterUrl, director, cast[], comingSoon

- Showtime: movieId, hall, times[]

- Reservation: movieId, movieTitle, hall, time, createdAt

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Getting Started**

```
flutter pub get
flutter run
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Known Behavior / Limitations**

- No database/persistence — everything is in-memory.

- Seats are visual-only, not selectable or stored.

- Mock data for movies/showtimes (demo purposes).
