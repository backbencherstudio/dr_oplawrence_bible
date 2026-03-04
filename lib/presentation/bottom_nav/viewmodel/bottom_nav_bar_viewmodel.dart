import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final bottomNavBarProvider = StateNotifierProvider<BottomNavBarViewModel, int>(
  (ref) => BottomNavBarViewModel(),
);

class BottomNavBarViewModel extends StateNotifier<int> {
  BottomNavBarViewModel() : super(0);
  void onItemTapped(int index) {
    state = index;
  }
}
class ParentScreenProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  //  ADD THIS
  void resetToHome() {
    _selectedIndex = 0;
    notifyListeners();
  }
}