import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/data/post_provider.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:apu_assignment/features/resources/presentation/viewmodel/resources_viewmodel.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

class PostViewModel extends Notifier<bool> {
  @override
  bool build() {
    return false; //default set false
  }

  bool showResetDialog(List<String> fieldValues){
    return fieldValues.any((Value) => Value.trim().isNotEmpty);
  }

  //Make the Date Format consistency
  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  //Make the Time Format consistency
  String formatTime(TimeOfDay time, BuildContext context) {
    return time.format(context); 
  }

  Future<bool> createPost(Map<String, dynamic> contents, String type, String authName) async {
  if (contents.isEmpty) return false;

  try {
    state = true; 
    
    final post = PostModel(
      content: contents, 
      createdAt: DateTime.now(),
      type: type.toLowerCase(),
      author: authName,
    );
    
    // Get data from repository
    final repository = ref.read(postRepositoryProvider);
    final success = await repository.uploadPost(post);
  
    if (success) {

      ref.invalidate(resourcesProvider); 
    }
    
    return success;
  } catch (e) {
    debugPrint("Post Error: $e");
    return false;
  } finally {
    // Prevent system crash by always loading
    state = false; 
  }
}
}

final postViewModelProvider = NotifierProvider<PostViewModel, bool>(() {
  return PostViewModel();
});