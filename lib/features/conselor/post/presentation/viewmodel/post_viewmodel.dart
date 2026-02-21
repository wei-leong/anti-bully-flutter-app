import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/data/post_provider.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';


final postRepositoryProvider = Provider((ref) => PostRepository());

class PostViewModel extends Notifier<bool> {
  @override
  bool build() {
    return false; //default set false
  }

  Future<bool> createPost(String content) async {
    if (content.isEmpty) return false;

    state = true; 
    
    // get repository from ref
    final repository = ref.read(postRepositoryProvider);
    final post = PostModel(content: content, createdAt: DateTime.now());
    
    final success = await repository.uploadPost(post);
    
    state = false; 
    return success;
  }
}

final postViewModelProvider = NotifierProvider<PostViewModel, bool>(() {
  return PostViewModel();
});