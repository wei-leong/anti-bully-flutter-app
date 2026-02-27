import 'package:flutter/material.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';

class PostRepository {
  Future<bool> uploadPost(PostModel post) async {

    await Future.delayed(const Duration(seconds: 1));
    debugPrint("Repository: 成功上传内容 -> ${post.content}");
    return true;
  }
}