import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/services/post_service.dart';

import '../models/post_model.dart';

final PostNotifierProvider = StateNotifierProvider<PostNotifier, bool>((ref) => PostNotifier(ref));
final PostListProvider = FutureProvider.autoDispose<List<PostModel>>((ref) async {
  final postNotifier = ref.watch(PostNotifierProvider.notifier);
  return postNotifier.getPosts();
});

final PostProvider = FutureProvider.family<PostModel, String>((ref, id) async {
  final postNotifier = ref.watch(PostNotifierProvider.notifier);
  return postNotifier.getPost(id);
});

class PostNotifier extends StateNotifier<bool>{
  final Ref _ref;
  late final PostService _postService = _ref.read(PostServiceProvider);
  PostNotifier(this._ref) : super(false);

  Future<void> createPost(PostModel post) async {
    try {
      state = true;
      await _postService.createPost(post);
    } catch (e) {
      throw Exception(e);
    } finally {
      state = false;
    }
  }

  Future<List<PostModel>> getPosts() async {
    try {
      state = true;
      final posts = await _postService.getPosts();
      return posts;
    } catch (e) {
      throw Exception(e);
    } finally {
      state = false;
    }
  }

  Future<PostModel> getPost(String id) async {
    try {
      state = true;
      final post = await _postService.getPost(id);
      return post;
    } catch (e) {
      throw Exception(e);
    } finally {
      state = false;
    }
  }
}