import 'package:cloud_firestore/cloud_firestore.dart';

enum ReportType { physical, verbal, cyber, social, unknown }

enum ReportUrgentLevel { low, med, high }

enum ReportStatus { pending, inProgress, complete }

class ReportModel {
  final String? id;
  final String location;
  final String description;
  final ReportType reportType;
  final ReportUrgentLevel reportUrgentLevel;
  final ReportStatus reportStatus;
  final DateTime incidentDate;
  final DateTime createdAt;

  ReportModel({
    this.id,
    required this.location,
    required this.description,
    required this.reportType,
    required this.reportUrgentLevel,
    required this.reportStatus,
    required this.incidentDate,
    required this.createdAt,
  });

  static ReportType _firebaseToType(String reportType) {
    switch (reportType) {
      case 'physical':
        return ReportType.physical;
      case 'verbal':
        return ReportType.verbal;
      case 'cyber':
        return ReportType.cyber;
      case 'social':
        return ReportType.social;
      default:
        return ReportType.unknown;
    }
  }

  static ReportUrgentLevel _firebaseToUrgentLevel(String reportUrgentLevel) {
    switch (reportUrgentLevel) {
      case 'low':
        return ReportUrgentLevel.low;
      case 'med':
        return ReportUrgentLevel.med;
      case 'high':
        return ReportUrgentLevel.high;
      default:
        return ReportUrgentLevel.low;
    }
  }

  static ReportStatus _firebaseToStatus(String reportPriority) {
    switch (reportPriority) {
      case 'pending':
        return ReportStatus.pending;
      case 'inProgress':
        return ReportStatus.inProgress;
      case 'complete':
        return ReportStatus.complete;
      default:
        return ReportStatus.pending;
    }
  }

  // Create Model from Firebase
  factory ReportModel.fromMap(Map<String, dynamic> data, String id) {
    return ReportModel(
      id: id,
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      reportType: _firebaseToType(data['reportType'] ?? ''),
      reportUrgentLevel: _firebaseToUrgentLevel(data['reportUrgentLevel'] ?? ''),
      reportStatus: _firebaseToStatus(data['reportStatus'] ?? ''),
      incidentDate: (data['incidentDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Converts User Model into a Map for Writing to Firestore
  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'description': description,
      'reportType': reportType.name,
      'reportUrgentLevel': reportUrgentLevel.name,
      'reportStatus': reportStatus.name,
      'incidentDate': Timestamp.fromDate(incidentDate),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
