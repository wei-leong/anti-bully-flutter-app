import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String location;
  final String date;
  final String description;
  final String status;
  final int urgentLevel;

  ReportModel({
    required this.location,
    required this.date,
    required this.description,
    required this.status,
    required this.urgentLevel,
  });

  // Map to data
  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      location: data['location'] ?? 'Unknown',
      date: data['date'] ?? 'N/A',
      description: data['description'] ?? '',
      status: data['status'] ?? 'Pending',
      urgentLevel: data['Level'] ?? 1, 
    );
  }
}