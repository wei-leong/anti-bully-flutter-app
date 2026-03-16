import 'package:apu_assignment/core/navigation/main_wrapper_conselor.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/screens/resources_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apu_assignment/features/conselor/post/data/post_provider.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:apu_assignment/features/conselor/post/presentation/viewmodel/post_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/presentation/widget/post_type.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}
 
class _PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _textController = TextEditingController();
  String _selecttype = "Articles";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(firebaseAuthProvider);
    final currentUser = auth.currentUser;
    final userNameAsyncValue = ref.read(userNameProvider(currentUser!.uid));
    final currentName = userNameAsyncValue.when(
    data: (user) => user?.name ?? '',
    error: (error, stack) => "Counselor",
    loading: () => "Counselor",
  );

    final colorScheme = Theme.of(context).colorScheme;
    final Loading = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        // Quick Button
        leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _textController.clear(); 
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainWrapperConselor()),
          (route) => false, 
        );
        },
      ),
        centerTitle: true,
        title: PostType( 
          selectedType: _selecttype,
          onTypeChanged: (newType) {
            setState(() {
              _selecttype = newType;
            });
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton(
              onPressed:  (Loading || currentName == "Counselor") ? null: () async{
                final text = _textController.text; 
                if (text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Text somethings......"))
                  );
                  return;
                }

                final success = await ref.read(postViewModelProvider.notifier).createPost(text, _selecttype);
                if (success && mounted){
                  _textController.clear();
                  Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainWrapperConselor()),
                  (route) => false, 
                );
                }else if (mounted){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Update Failed, Try Again"))
                  );
                }
              },
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact, 
              ),
              child: Loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text("Post"),
            ),
          ),
        ],
      ),
      // Text (Get user input)
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: TextField(
          controller: _textController,
          maxLines: null, 
          expands: true,  
          textAlignVertical: TextAlignVertical.top, 
          decoration: InputDecoration(
            hintText: "Text Somethings.....",
            border: InputBorder.none, 
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}