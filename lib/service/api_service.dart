import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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

  Future<dynamic> getDoc() async {
    var uri = Uri(
      scheme: 'http',
      host: '192.168.43.93',
      port: 8080,
      path: 'api/file/download/hello',
    );
    var response = await client.get(uri,
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

  Future<String> postSendQuestion(String question) async {
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
}
