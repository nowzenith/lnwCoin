
import 'package:flutter/cupertino.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int newIndex) {
    if (_index != newIndex) {
      _index = newIndex;
      notifyListeners();  // Notify all listening widgets of the change
    }
  }

  void changePage(int newIndex) {
    index = newIndex;  // Set new index which also notifies listeners
  }

}
