import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/photo_model.dart';

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/photos';
  static List<Photo> parsePhotos(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Photo> photos =
        list.map((model) => Photo.fromJson(model)).toList();
    return photos;
  }

  static Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) // status code OK
    {
      return compute(parsePhotos, response.body);
    } else {
      throw Exception('Can\'t get photos');
    }
  }
}
