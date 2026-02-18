import 'package:apu_assignment/core/navigation/main_wrapper_conselor.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/resources/screens/resources_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _textController = TextEditingController();

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
        // 1. 左上角放一个 X 按钮
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton(
              onPressed: () {
                print("Posting: ${_textController.text}");
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainWrapperConselor()),
                (route) => false, 
              );
              },
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact, // 让按钮紧凑一点
              ),
              child: const Text("Post"),
            ),
          ),
        ],
      ),
      // 3. 下面空白部分放输入框
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: TextField(
          controller: _textController,
          // 使输入框充满剩余空间并从顶部开始
          maxLines: null, // 设置为 null 则根据内容自动换行
          expands: true,  // 配合 maxLines: null 使用，撑开整个父组件
          textAlignVertical: TextAlignVertical.top, // 文字从顶部开始
          decoration: InputDecoration(
            hintText: "Text Somethings.....",
            border: InputBorder.none, // 去掉输入框边框，看起来更像空白页
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}