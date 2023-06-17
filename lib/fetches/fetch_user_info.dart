import 'dart:convert';
import 'package:kodeks/model/user_entity.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<UserEntity> fetchUserInfo() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final response = await ApiService().getInfoUser(
      preferences.getInt("idKey")!);
  return UserEntity.fromJson(jsonDecode(response));
}