
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const String apiUrl =
      'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http
        .get(Uri.parse(apiUrl))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      return jsonList.map((json) {
        return Post.fromJson(json as Map<String, dynamic>);
      }).toList();
    } else {
      throw Exception(
        'Failed to load posts. Status code: ${response.statusCode}',
      );
    }
  }
}