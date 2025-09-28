import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_app/bloc/posts_bloc.dart';
import 'package:infinite_scroll_app/widgets/loading_widget.dart';
import 'package:infinite_scroll_app/widgets/post_list_item.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollControllar = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollControllar.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollControllar
      ..removeListener(_onScroll)
      ..dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollControllar.position.maxScrollExtent;
    final _currentScroll = _scrollControllar.offset;
    if (_currentScroll >= maxScroll * 0.9) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'), centerTitle: true),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return LoadingWidget();
            case PostStatus.success:
              if (state.posts.isEmpty) {
                return Center(child: Text('No Posts'));
              }
              return ListView.builder(
                controller: _scrollControllar,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? LoadingWidget()
                      : PostListItem(post: state.posts[index]);
                },
              );
            case PostStatus.error:
              return Center(child: Text(state.errorMessage));
          }
        },
      ),
    );
  }
}
