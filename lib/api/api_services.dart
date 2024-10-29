import 'dart:convert';

import 'package:api_crud/models/post/post_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const baseUrl = "jsonplaceholder.typicode.com";

  static Future<List<PostModel?>> fetchAll(String endpoint) async {
    var url = Uri.https(
      baseUrl,
      endpoint,
    );
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final resul = data.map((e) {
        return PostModel.fromJson(e);
      }).toList();
      return resul;
    } else {
      throw Exception('API has error');
    }
  }

  static Future<PostModel?> fetchById(String endpoint, int id) async {
    var url = Uri.https(
      baseUrl,
      "$endpoint/$id",
    );
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PostModel.fromJson(data);
    } else {
      throw Exception('API has error');
    }
  }

  static Future<String> createPost(String endpoint, String title, String body) async {
    var url = Uri.https(
      baseUrl,
      endpoint,
    );
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "title": title,
          "body": body,
          "userId": 1
        }));
    if (response.statusCode == 201) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('API has error');
    }
  }

  static Future<String> updatePost(String endpoint, String title, String body, int id) async {
    var url = Uri.https(
      baseUrl,
      "$endpoint/$id",
    );
    // Await the http get response, then decode the json-formatted response.
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "title": title,
          "body": body,
          "userId": 1
        }));
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('API has error');
    }
  }

  static Future<String> deletePost(String endpoint, String id) async {
    var url = Uri.https(
      baseUrl,
      "$endpoint/$id",
    );
    // Await the http get response, then decode the json-formatted response.
    var response = await http.delete(url, headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('API has error');
    }
  }
}
