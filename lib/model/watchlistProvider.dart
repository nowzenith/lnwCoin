import 'package:flutter/material.dart';

List<String> _watchlist = [];

class watchListProvider with ChangeNotifier {
  List<String> get watchlist => _watchlist;

  void addFavorite(String item) {
    if (!_watchlist.contains(item)) {
      _watchlist.add(item);
      notifyListeners();
    }
  }

  void removeFavorite(String item) {
    if (_watchlist.contains(item)) {
      _watchlist.remove(item);
      notifyListeners();
    }
  }
}
