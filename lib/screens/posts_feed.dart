import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';

import '../providers/post_provider.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';

class PostsFeed extends ConsumerWidget {
  const PostsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CreatePostScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: ref.watch(PostListProvider).when(
            data: (posts) {
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(post: post);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
    );
  }
}
