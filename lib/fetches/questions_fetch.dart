import 'dart:convert';
import 'package:kodeks/service/api_service.dart';

import '../model/questions_model.dart';

Future<QuestionsModel> fetchQuestions() async {
  final response = await ApiService().getQuestionsAll();
  return QuestionsModel.fromJson(jsonDecode(response));
}
