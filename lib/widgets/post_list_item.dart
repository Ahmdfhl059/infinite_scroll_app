import 'package:flutter/material.dart';
import 'package:infinite_scroll_app/models/post_models.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Text(post.id.toString()),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        ),
    );
  }
}
