import 'dart:convert';

import 'package:kodeks/model/petition_model.dart';
import 'package:kodeks/service/api_service.dart';

Future<PetitionModel> fetchSelectPetition(int id) async {
  final response = await ApiService().getPetitionById(id);
  return PetitionModel.fromOneJson(jsonDecode(response));
}