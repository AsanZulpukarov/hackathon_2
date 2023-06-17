import 'dart:convert';
import 'package:kodeks/model/openQuestionModel.dart';
import 'package:kodeks/service/api_service.dart';

import '../model/questions_model.dart';

Future<OpenQuestionModel> fetchOpenQuestion(String id) async {
  final response = await ApiService().getQuestionsById(id);
  return OpenQuestionModel.fromJson(jsonDecode(response));
}
