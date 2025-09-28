import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_app/models/post_models.dart';

class PostApi {
  static Future<List<Post>> getPosts([
    int startIndext = 0,
    int limit = 20,
  ]) async {
    try {
      String url =
          "https://jsonplaceholder.typicode.com/posts?_start=$startIndext&_limit=$limit";
      var respons = await http.get(Uri.parse(url));

      List<Post> posts = (json.decode(
        respons.body,
      )).map<Post>((jsonPost) => Post.fromJson(jsonPost)).toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
