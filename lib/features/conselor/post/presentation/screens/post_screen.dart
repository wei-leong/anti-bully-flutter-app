import 'package:apu_assignment/core/navigation/main_wrapper_conselor.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/screens/resources_screen.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

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
              onPressed: () {
                final text = _textController.text; 
                debugPrint("Posting: $text");

                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainWrapperConselor()),
                (route) => false, 
              );
              },
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact, 
              ),
              child: const Text("Post"),
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