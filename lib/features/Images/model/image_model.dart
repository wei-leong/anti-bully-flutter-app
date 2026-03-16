class PostImageModel {
  final String base64String;
  final String? label;

  PostImageModel({required this.base64String, this.label});

  // validate the image size is acceptable
  bool get isValid => base64String.isNotEmpty && base64String.length > 100;
}