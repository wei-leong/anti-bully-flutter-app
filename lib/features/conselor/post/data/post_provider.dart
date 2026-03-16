import 'package:flutter/material.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> uploadPost(PostModel post) async {
    try{
    String collectionPath = post.type.toLowerCase();

    Map<String, dynamic> firestore = {
      "author": post.author,
      "type": post.type,
      "createdAt": Timestamp.fromDate(post.createdAt),
      "displayDate": "${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}",
      "status": "pending",
    };

    // Get content details such as link, title and content
    post.content.forEach((key, value) {
        String formattedKey = key.toLowerCase().replaceAll(' ', '_').replaceAll('&', 'and');
        if (value.toString().trim().isNotEmpty) {
          firestore[formattedKey] = value;
        }
      });

    await _firestore.collection(collectionPath).add(firestore);
      return true;
    }catch(e){
      print("Firebase Updated Error $e, Try Again");
      return false;
    }
  }
}