import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/data/post_provider.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';

// 定义 Repository 的 Provider
final postRepositoryProvider = Provider((ref) => PostRepository());

// ViewModel: 管理发布状态 (false=未发布, true=发布中)
class PostViewModel extends Notifier<bool> {
  @override
  bool build() {
    return false; // 初始状态为 false (未加载)
  }

  Future<bool> createPost(String content) async {
    if (content.isEmpty) return false;

    state = true; // 开始 loading
    
    // 从 ref 获取 repository
    final repository = ref.read(postRepositoryProvider);
    final post = PostModel(content: content, createdAt: DateTime.now());
    
    final success = await repository.uploadPost(post);
    
    state = false; // 结束 loading
    return success;
  }
}

// 对应的 Provider 定义也更简单
final postViewModelProvider = NotifierProvider<PostViewModel, bool>(() {
  return PostViewModel();
});