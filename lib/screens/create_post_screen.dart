import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/post_model.dart';
import 'package:hackathon_app_rubix/providers/post_provider.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';
import 'package:hackathon_app_rubix/screens/posts_feed.dart';
import 'package:hackathon_app_rubix/util/photo_picker.dart';

import '../widgets/custom_scaffold.dart';

class CreatePostScreen extends ConsumerWidget {
  CreatePostScreen({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? imgUrl;
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              imgUrl = await pickImage();
            },
            icon: const Icon(Icons.image),
            label: const Text('Add Image'),
          ),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(PostNotifierProvider.notifier)
                  .createPost(PostModel(
                    title: _titleController.text,
                    body: _bodyController.text,
                    imgUrl: imgUrl,
                    uid: ref.read(userProvider.notifier).state!.uid,
                  ))
                  .whenComplete(() => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => PostsFeed())));
            },
            child: const Text('Create Post'),
          ),
        ],
      ),
    );
  }
}
