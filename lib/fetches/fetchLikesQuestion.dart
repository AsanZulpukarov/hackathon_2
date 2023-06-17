import 'dart:convert';
import 'package:kodeks/service/api_service.dart';

import '../model/likesQuestionModel.dart';

Future<LikesQuestionModel> fetchLikesQuestion(String id, String userId) async {
  final response = await ApiService().getLikesQuestion(id, userId);
  return LikesQuestionModel.fromJson(jsonDecode(response));
}
