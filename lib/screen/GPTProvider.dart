import 'package:flutter/material.dart';
import 'package:kodeks/model/GPTModel.dart';

import '../fetches/fetchGPT.dart';

class GPTProvider extends ChangeNotifier {
  late GPTModel _gpt;

  void setCurrentUser(String questionController) {
    Future<GPTModel> ans = fetchGPT(questionController);
    _gpt = gpt;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  //Getter for current user
  GPTModel get gpt => _gpt;
}
