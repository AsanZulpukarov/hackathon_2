import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  var client = http.Client();

  var ip = '192.168.43.33';
  var port = 2323;

  Future<String> postSingUp(var json) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: '/api/register',
    );
    var response = await client.post(uri,
        body: jsonEncode(json),
        headers: {"Content-Type": "application/json", "Accept": "*/*"});
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return response.body;
    } else {
      print('error not found');
      print(response.body);
      return '';
    }
  }

  Future<String> postSingIn(String inn, String password) async {
    Map<String, String> json = {"inn": inn, "password": password};

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/auth',
    );
    var response = await client.post(uri,
        body: jsonEncode(json),
        headers: {"Content-Type": "application/json", "Accept": "*/*"});
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return response.body;
    } else {
      print('error not found');
      print(response.body);
      return '';
    }
  }

  Future<dynamic> postSendQuestion(String question) async {
    Map<String, dynamic> jsonQues = {
      "message": question,
    };

    var uri = Uri(
      scheme: 'http',
      host: '192.168.43.93',
      port: 8080,
      path: 'api/openAi',
    );
    var response = await client
        .post(uri, body: jsonEncode(jsonQues), headers: <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<dynamic> getInfoUser(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/get/user/$id',
    );
    print(uri);
    var response = await client.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        HttpHeaders.acceptCharsetHeader: 'utf-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print('error not found');
      return '';
    }
  }

  Future<dynamic> getCategoryAll() async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/category/get/all',
    );
    print(uri);
    var response = await client.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        HttpHeaders.acceptCharsetHeader: 'utf-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return response.body;
    } else {
      print('error not found');
      print(response.body);
      return '';
    }
  }

  Future<dynamic> getInstructionByIdCategory(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/instruction/get/by/category/${id}',
    );
    print(uri);
    var response = await client.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        HttpHeaders.acceptCharsetHeader: 'utf-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return response.body;
    } else {
      print('error not found');
      print(response.body);
      return '';
    }
  }

  Future<bool> postCheckCertificate(XFile file, int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/lawyer/create/$id',
    );
    print(uri);
    var request = http.MultipartRequest('POST', uri);

//for image and videos and files

// request.files.add(await http.MultipartFile.fromPath("images", path));
    final fileBytes = await file.readAsBytes();
    final httpImage = http.MultipartFile.fromBytes(
        'certificate', fileBytes.toList(),
        contentType: MediaType('image', 'jpeg'), filename: file.name);
//for completeing the request
    request.files.add(httpImage);
    var response = await request.send();

//for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
// final responseData = json.decode();

    if (response.statusCode == 200) {
      print("SUCCESS photoprofile add");
      print(responsed.body);
      return true;
    } else {
      print(response.statusCode);
      print(responsed.body);
      print("ERROR photo profile");
      return false;
    }
  }
}
