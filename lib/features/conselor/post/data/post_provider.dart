import 'package:flutter/material.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> uploadPost(PostModel post) async {
    try{
    String collectionPath = post.type.toLowerCase();

    await _firestore.collection(collectionPath).add({
      'title': post.content.length > 30 ? "${post.content.substring(0, 30)}..." : post.content,
      'subtitle': post.content,
      'source': post.author,
      'type': collectionPath,
      'createdAt': Timestamp.fromDate(post.createdAt),
      'durationOrSize': "${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
  });
  return true;

    }catch(e){
      print("Firebase Updated Error $e, Try Again");
      return false;
    }
  }
}