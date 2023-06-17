import 'dart:convert';
import 'package:kodeks/model/category_model.dart';
import 'package:kodeks/service/api_service.dart';


Future<CategoryModel> fetchCategory() async {
  final response = await ApiService().getCategoryAll();
  return CategoryModel.fromJson(jsonDecode(response));
}