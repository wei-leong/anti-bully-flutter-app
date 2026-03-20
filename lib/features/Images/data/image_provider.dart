import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImagesProvider {

  //control the image size into 700KB
  static const int maxByteSize = 700 * 1024; 

  // Encode Process
  Future<String?> compressAndEncode(String filePath) async {
    try {
      
      // First ZIP
      var result = await FlutterImageCompress.compressWithFile(
        filePath,
        minWidth: 800,
        minHeight: 800,
        quality: 80,
      );

      // Repeated ZIP until the size acceptable
      int quality = 70;
      while (result != null && result.length > maxByteSize && quality > 10) {
        result = await FlutterImageCompress.compressWithFile(
          filePath,
          minWidth: 600,
          minHeight: 600,
          quality: quality,
        );
        quality -= 15; // low quality
      }

      if (result == null || result.length > 1024 * 1024) {
        return "The picture is over size, please change another!";
      }

      // Encode to 64 bit
      return base64Encode(result);
    } catch (e) {
      print("Image Processing Error: $e");
      return null;
    }
  }

  // Decode process
  static Uint8List? decodeBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;

    try {
      
      String cleanBase64 = base64String.contains(',') 
          ? base64String.split(',').last 
          : base64String;
          
      return base64Decode(cleanBase64.trim());
    } catch (e) {
      print("Decode Error: $e");
      return null;
    }
  }
}