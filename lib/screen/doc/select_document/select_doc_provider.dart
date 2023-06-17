import 'package:flutter/cupertino.dart';

class SelectCatProvider extends ChangeNotifier {
  String category = '';
  void toggleSelect(String cat) {
    category = cat;
    notifyListeners();
  }
}
