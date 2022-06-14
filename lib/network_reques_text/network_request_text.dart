import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../comment_model/comment_model.dart';


class NetworkRequestText {
  static const String url = 'https://jsonplaceholder.typicode.com/comments';
  static List<Comment> parseComments(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Comment> comments =
        list.map((model) => Comment.fromJson(model)).toList();
    return comments;
  }

  static Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) // status code OK
    {
      return compute(parseComments, response.body);
    } else {
      throw Exception('Can\'t get Comments');
    }
  }
}