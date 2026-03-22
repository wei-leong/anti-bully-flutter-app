import 'package:apu_assignment/core/navigation/main_wrapper_conselor.dart';
import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/Images/presentation/view_model/image_view_model.dart';
import 'package:apu_assignment/features/Images/presentation/widget/image_widget.dart';
import 'package:apu_assignment/features/auth/data/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:apu_assignment/features/conselor/post/model/post_model.dart';
import 'package:apu_assignment/features/conselor/post/presentation/viewmodel/post_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/post/presentation/widget/post_type.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}
 
class _PostScreenState extends ConsumerState<PostScreen> {
  final Map<String, TextEditingController> controller = {};
  final TextEditingController _textController = TextEditingController();
  String _selecttype = "Articles";

  @override
  void initState(){
    super.initState();
    initField();
  }

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void initField() {
      final fields = PostModel.getFieldsForType(_selecttype);
      final oldControllers = Map<String, TextEditingController>.from(controller);
      
      // clear controller
      controller.clear();

      for (var field in fields) {
        controller[field] = TextEditingController();
      }
      //Use to prevent crash when many controller is request
      WidgetsBinding.instance.addPostFrameCallback((_) {
        oldControllers.forEach((key, c) => c.dispose());
      });
    }

  String CombineContent() {
  StringBuffer buffer = StringBuffer();
  controller.forEach((field, ctrl) {
    final cleanField = field.replaceAll(':', '').trim();
    buffer.writeln("$cleanField: ${ctrl.text.trim()}");
  });
  return buffer.toString();
}

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);
    final currentUser = auth.currentUser;
    // If user logout stop stream process
    if (currentUser == null) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final userNameAsyncValue = ref.watch(userNameProvider(currentUser.uid));
    final currentName = userNameAsyncValue.when(
    data: (user) => user?.name ?? '',
    error: (error, stack) => "Counselor",
    loading: () => "Counselor",
  );

    final colorScheme = Theme.of(context).colorScheme;
    final Loading = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PostType( 
          selectedType: _selecttype,
          onTypeChanged: (newType) {
          final isModifield = controller.values.any((c) => c.text.isNotEmpty);
          if (newType == _selecttype){
            return;
          }else if (isModifield){
            showResetDialog(newType);
          }else {
            setState(() {
              _selecttype = newType;
              initField();
            });
          }
        },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton(
              onPressed:  (Loading || currentName == "Counselor") ? null: () async{
                final Map<String, String> contents = {};
                  controller.forEach((key, ctrl) {
                    contents[key] = ctrl.text.trim();
                  });
                if (controller.values.every((c) => c.text.trim().isEmpty)){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please Fill in One of the Blank"))
                  );
                  return;
                }

                final success = await ref.read(postViewModelProvider.notifier).createPost(contents, _selecttype,currentName);
                if (success && mounted){
                  _textController.clear(); 
                  controller.forEach((key, ctrl) {
                    ctrl.clear();
                  });
                  initField();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
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
      // Get user input
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: controller.entries.map((entry) {
          final fieldName = entry.key.toLowerCase();
          if (entry.key.toLowerCase().contains("image")){
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final base64 = await ref.read(imageViewModelProvider.notifier).pickAndProcessImage();
                      
                      if (base64 != null) {
                        setState(() {
                          entry.value.text = base64; // Save image to 64 bit into controller
                        });
                      }
                    },
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: entry.value.text.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Base64Image(base64Data: entry.value.text), 
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                                Text("Click to upload images", style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (fieldName.contains("duration")) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: entry.value,
                // Use to lock the keyboard by only number
                keyboardType: TextInputType.number, 
                // User cannot use other type of word such as +, ?, space
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, 
                ],
                decoration: InputDecoration(
                  labelText: entry.key,
                  hintText: "Enter minutes (e.g. 30)",
                  suffixText: "mins", 
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          }
          if (fieldName.contains("date")) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: entry.value,
                readOnly: true, 
                decoration: InputDecoration(
                  labelText: entry.key,
                  hintText: "Select ${entry.key}",
                  prefixIcon: Icon(fieldName.contains("date") ? Icons.calendar_today : Icons.access_time),
                  border: const OutlineInputBorder(),
                ),
                onTap: () => _handleDateTimePicker(context, entry.key, entry.value),
              ),
            );
          }
          if (fieldName.contains("time")) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: entry.value,
                readOnly: true, 
                decoration: InputDecoration(
                  labelText: entry.key,
                  hintText: "Select ${entry.key}",
                  prefixIcon: Icon(fieldName.contains("date") ? Icons.calendar_today : Icons.access_time),
                  border: const OutlineInputBorder(),
                ),
                onTap: () => _handleDateTimePicker(context, entry.key, entry.value),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextField(
              controller: entry.value,
              // Content and Description will have bigger size to write more word
              maxLines: (entry.key == "Content" || entry.key == "Description") ? 8 : 1,
              decoration: InputDecoration(
                labelText: entry.key, 
                alignLabelWithHint: true,
                hintText: "Enter ${entry.key.toLowerCase()}...",
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  void showResetDialog(String newType){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reset Dialog"),
        content: const Text("Changing type will be reset your word, are u sure to do that?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selecttype = newType;
                initField();
              });
            Navigator.pop(context);
            },
            child: const Text("Confirm")
          ),
        ],
    ));
  }

  Future<void> _handleDateTimePicker(BuildContext context, String fieldName, TextEditingController ctrl) async {
  final name = fieldName.toLowerCase();

  if (name.contains("date")) {
    // Select Date (Date picker)
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Format = yyyy - mmm - dd
      setState(() {
        ctrl.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  } else if (name.contains("time")) {

    //Time picker
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Format = hh-mm
      setState(() {
        ctrl.text = pickedTime.format(context);
      });
    }
  }
}
}
