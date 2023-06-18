import 'dart:convert';

import 'package:kodeks/model/petition_model.dart';
import 'package:kodeks/service/api_service.dart';

Future<PetitionModel> fetchPetitions() async {
  final response = await ApiService().getPetitionsAll();
  return PetitionModel.fromJson(jsonDecode(response));
}