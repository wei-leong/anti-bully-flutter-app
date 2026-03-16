import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';

class PostModel {
  final String content;
  final DateTime createdAt;
  final String type;
  final String author;

  PostModel({
    required this.content, 
    required this.createdAt,
    required this.type,
    this.author = "Counselor"
  });
}