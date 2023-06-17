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

  Future<bool> postCreateMyQuestion(
      {required String title,
      required String myQuestion,
      required String userId,
      required String categoryId}) async {
    Map<String, dynamic> json = {
      "title": title,
      "question": myQuestion,
      "user_id": userId,
      "category_id": categoryId
    };
    print(json);

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/create',
    );
    var response = await client.post(uri,
        body: jsonEncode(json),
        headers: {"Content-Type": "application/json", "Accept": "*/*"});
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return true;
    } else {
      print('error not found');
      print(response.body);
      return false;
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

  Future<bool> postLikeQuestion(
      {required String questionId, required String userId}) async {
    var json = {"question_id": questionId, "user_id": userId};
    print(json);

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/like/create',
    );
    var response = await client.post(uri,
        body: jsonEncode(json),
        headers: {"Content-Type": "application/json", "Accept": "*/*"});
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return true;
    } else {
      print('error not found');
      print(response.body);
      return false;
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

  Future<dynamic> getQuestionsById(String id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/get/$id',
    );
    print(uri);
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

  Future<dynamic> getComment(String id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/comment/get/by/question/$id',
    );
    print(uri);
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

  Future<dynamic> getLikesQuestion(String id, String userId) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/like/get/by/question/$id/$userId',
    );
    print(uri);
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

  Future<dynamic> deleteLikesQuestion(String id, String userId) async {
    var json = {"question_id": id, "user_id": userId};

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/like/delete/',
    );
    print(uri);
    var response = await client.delete(uri,
        body: jsonEncode(json),
        headers: {"Content-Type": "application/json", "Accept": "*/*"});
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      return true;
    } else {
      print('error not found');
      print(response.body);
      return false;
    }
  }

  Future<dynamic> getQuestionsAll() async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/get/all',
    );
    print(uri);
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

  Future<dynamic> getInstructionByIdCategory(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/instruction/get/by/category/${id}',
    );
    print(uri);
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

  Future<dynamic> getInstructionDocument(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/instruction/document/${id}',
    );
    print(uri);
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
}
