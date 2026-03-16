// features/conselor/post/presentation/viewmodel/image_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apu_assignment/features/Images/data/image_provider.dart';

final imageViewModelProvider = StateNotifierProvider<ImageViewModel, bool>((ref) {
  return ImageViewModel();
});

class ImageViewModel extends StateNotifier<bool> {
  ImageViewModel() : super(false); 

  final ImagesProvider _service = ImagesProvider();
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickAndProcessImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    state = true; // Start Loading
    final base64String = await _service.compressAndEncode(image.path);
    state = false; // End Loading
    
    return base64String;
  }
}