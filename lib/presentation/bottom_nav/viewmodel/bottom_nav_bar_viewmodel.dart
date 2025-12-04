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
