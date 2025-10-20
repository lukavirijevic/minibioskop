import 'package:flutter/foundation.dart';


class WishlistProvider extends ChangeNotifier {
  final Set<int> _ids = {};
  Set<int> get ids => _ids;


  bool contains(int id) => _ids.contains(id);

  void toggle(int id) {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    notifyListeners();
  }


  void clear() {
    _ids.clear();
    notifyListeners();
  }
}