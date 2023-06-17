import 'dart:convert';
import 'package:kodeks/service/api_service.dart';

import '../model/instruction_model.dart';


Future<InstructionModel> fetchInstructionByIdCategory(int id) async {
  final response = await ApiService().getInstructionByIdCategory(id);
  return InstructionModel.fromJson(jsonDecode(response));
}