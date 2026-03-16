import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:apu_assignment/features/Images/data/image_provider.dart';

class Base64Image extends StatelessWidget {
  final String? base64Data;
  final double? width;
  final double? height;
  final BoxFit fit;

  const Base64Image({
    super.key, 
    required this.base64Data,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {

    final Uint8List? bytes = ImagesProvider.decodeBase64(base64Data);

    if (bytes == null) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, color: Colors.grey),
      );
    }

    return Image.memory(
      bytes,
      width: width,
      height: height,
      fit: fit,
      // prevent the picture is bigger make system crash
      gaplessPlayback: true, 
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
}