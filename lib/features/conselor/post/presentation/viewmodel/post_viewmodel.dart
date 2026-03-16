import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/data/post_provider.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/viewmodel/resources_viewmodel.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

class PostViewModel extends Notifier<bool> {
  @override
  bool build() {
    return false; //default set false
  }

  Future<bool> createPost(String content, String type, String authName) async {
    if (content.isEmpty) return false;

    state = true; 
    
    // get repository from ref
    final repository = ref.read(postRepositoryProvider);
    final post = PostModel(
      content: content, 
      createdAt: DateTime.now(),
      type: type.toLowerCase(),
      author: authName,
      );
    
    final success = await ref.read(postRepositoryProvider).uploadPost(post);
  
  if (success) {
    ref.invalidate(allResourcesProvider);
  }
    
    state = false; 
    return success;
  }
}

final postViewModelProvider = NotifierProvider<PostViewModel, bool>(() {
  return PostViewModel();
});