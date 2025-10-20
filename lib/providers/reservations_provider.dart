import 'package:flutter/foundation.dart';
import '../models/reservation.dart';

class ReservationsProvider extends ChangeNotifier {
  final List<Reservation> _items = [];
  List<Reservation> get items => List.unmodifiable(_items);


  void add(Reservation r) {
    _items.add(r);
    notifyListeners();
  }

  void removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    notifyListeners();
  }
  
  void clear() {
    _items.clear();
    notifyListeners();
  }
}