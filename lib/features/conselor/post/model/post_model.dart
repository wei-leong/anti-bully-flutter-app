import 'package:apu_assignment/features/resources/model/resources_model.dart';

class PostModel {
  final Map<String, dynamic> content;
  final DateTime createdAt;
  final String type;
  final String author;

  PostModel({
    required this.content, 
    required this.createdAt,
    required this.type,
    this.author = "Counselor"
  });

  // The templete about which type have what item
  static List<String> getFieldsForType(String type) {
    switch (type.toLowerCase()) {
      case "articles":
        return ["Title", "Duration of Learn (EP: 5 min/ 2 hours)", "Image", "Content"];
      case "events":
        return ["Title", "Date","Start Time", "End Time", "Location", "Register link", "Image", "Content"];
      case "videos":
        return ["Title", "Video URL (Youtube Only)", "Content"];
      case "news":
        return ["Title", "Date", "Source", "Image", "Content"];
      default:
        return [""];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content, 
      'createdAt': createdAt,
      'type': type,
      'author': author,
    };
  }
}