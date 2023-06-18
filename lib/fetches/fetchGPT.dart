import 'dart:convert';
import 'package:kodeks/model/GPTModel.dart';
import 'package:kodeks/model/openQuestionModel.dart';
import 'package:kodeks/service/api_service.dart';

import '../model/questions_model.dart';

Future<GPTModel> fetchGPT(String question) async {
  final response = await ApiService().postSendQuestion(question);
  return GPTModel.fromJson(jsonDecode(response));
}
