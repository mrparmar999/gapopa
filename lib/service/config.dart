// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/Model.dart';

class ApiService {
  static Future<List<ImageModel>> fetchImages() async {
    const apiKey = '43403911-3232a705eae839b2f68b7d8a0';
    const url = 'https://pixabay.com/api/?key=$apiKey&q=yellow+flowers&image_type=photo';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<ImageModel> images = [];
      for (var item in jsonData['hits']) {
        images.add(ImageModel.fromJson(item));
      }
      return images;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
