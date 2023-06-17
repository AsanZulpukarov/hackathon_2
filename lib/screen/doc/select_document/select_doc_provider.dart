import 'package:flutter/cupertino.dart';

class SelectCatProvider extends ChangeNotifier {
  String category = '';
  bool buttonView=true;
  void toggleSelect(String cat) {
    category = cat;
    notifyListeners();
  }

  void buttonFalse() {
    buttonView=!buttonView;
    notifyListeners();
  }
}
