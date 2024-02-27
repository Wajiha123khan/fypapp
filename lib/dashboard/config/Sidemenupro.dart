import 'package:flutter/cupertino.dart';

class Sidemenupro with ChangeNotifier {
  int home_value = 0;
  void shift_new_page(int value) {
    home_value = value;
    notifyListeners();
  }
}
