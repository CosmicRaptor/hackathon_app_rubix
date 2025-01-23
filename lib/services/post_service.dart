import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/post_model.dart';

final PostServiceProvider = Provider((ref) => PostService());

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> createPost(PostModel post) async {
    try {
      await _firestore.collection('posts').add(post.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
  
  Future<List<PostModel>> getPosts() async {
    try {
      final snapshot = await _firestore.collection('posts').get();
      return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
  
  Future<PostModel> getPost(String id) async {
    try {
      final snapshot = await _firestore.collection('posts').doc(id).get();
      return PostModel.fromJson(snapshot.data()!);
    } catch (e) {
      throw Exception(e);
    }
  }
}