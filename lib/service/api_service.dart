import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ApiService {
  var client = http.Client();

  static const ip = '192.168.43.33';
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
    var json = {
      "query": question,
    };

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/chat/query',
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

  Future<bool> postNewComment(String questionId,int userId,String comment) async {
    Map<String, dynamic> json = {
      "question_id":int.parse(questionId),
      "user_id":userId,
      "comment" : comment
    };

    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/question/comment/create',
    );
    print(uri);
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

  Future<dynamic> getPetitionsAll() async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/petition/get/all/petitions',
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
  Future<dynamic> getPetitionById(int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/petition/get/$id',
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

  Future<bool> postAddPetition(XFile file,String title, String description, int id) async {
    var uri = Uri(
      scheme: 'http',
      host: ip,
      port: port,
      path: 'api/petition/create',
    );

    final Map<String, String> requestBody = {
      'title': title,
      'description': description,
      'user_id': id.toString()
    };
    print(uri);
    var request = http.MultipartRequest('POST', uri);

//for image and videos and files

// request.files.add(await http.MultipartFile.fromPath("images", path));
    final fileBytes = await file.readAsBytes();
    final httpImage = http.MultipartFile.fromBytes(
        'photo', fileBytes.toList(),
        contentType: MediaType('image', 'jpeg'), filename: file.name);
//for completeing the request
    request.files.add(httpImage);

    request.fields.addAll(requestBody);
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
