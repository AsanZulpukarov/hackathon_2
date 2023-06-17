import 'package:flutter/cupertino.dart';

class SelectCatProvider extends ChangeNotifier {
  String category = '';
  String categoryId = '';
  String userId='1';
  void toggleSelect(String cat,String id) {
    category = cat;
    categoryId=id;
    notifyListeners();
  }
}
