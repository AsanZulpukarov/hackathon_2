import 'dart:convert';
import 'package:kodeks/model/commentModel.dart';
import 'package:kodeks/model/openQuestionModel.dart';
import 'package:kodeks/service/api_service.dart';

Future<CommentModel> fetchComment(String id) async {
  final response = await ApiService().getComment(id);
  return CommentModel.fromJson(jsonDecode(response));
}
