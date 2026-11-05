
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com';

  // Mengambil daftar pengumuman
  Future<List<Post>> getPosts() async {
    final url = Uri.parse('$baseUrl/posts?_limit=10');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data pengumuman');
    }
  }

  // Mengambil komentar
  Future<List<dynamic>> getComments(int postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mengambil komentar');
    }
  }

  // Menambahkan pengumuman
  Future<Post> createPost(String title, String body) async {
    final url = Uri.parse('$baseUrl/posts');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'userId': 1,
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menambahkan pengumuman');
    }
  }
}
