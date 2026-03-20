import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String location;
  final String description;
  final String type;
  final String status;
  final int urgentLevel;

  ReportModel({
    required this.id,
    required this.location,
    required this.description,
    required this.type,
    required this.status,
    required this.urgentLevel,
  });

  // Map to data
  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      location: data['location'] ?? 'Unknown',
      description: data['description'] ?? '',
      type: data['reportType'] ?? 'N/A',
      status: data['reportStatus'] ?? 'Pending',
      urgentLevel: data['reportUrgentLevel'] ?? 1, 
    );
  }
}