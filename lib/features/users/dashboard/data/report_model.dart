import 'package:flutter/material.dart';

class ReportModel {
  final String caseId;
  final String date;
  final ReportStatus status;

  ReportModel({
    required this.caseId,
    required this.date,
    required this.status,
  });
}

enum ReportStatus {
  received, 
  inProgress,
  resolved;

  String get displayName {
    switch(this){
      case ReportStatus.received:
        return "Received";
      case ReportStatus.inProgress:
        return "In Progress";
      case ReportStatus.resolved: 
        return "Resolved";
    }
  }

  // Helper Function to Get Background Color
  Color get color{
    switch(this){
      case ReportStatus.received:
        return Colors.orange.shade700;
      case ReportStatus.inProgress:
        return Colors.blue.shade700;
      case ReportStatus.resolved: 
        return Colors.green.shade700;
    }
  }
  // Helper Function to Get Related Icon
  IconData get icon{
    switch(this){
      case ReportStatus.received:
        return Icons.inbox_rounded;
      case ReportStatus.inProgress:
        return Icons.pending_actions_rounded;
      case ReportStatus.resolved: 
        return Icons.check_circle_outline_rounded;
    }
  }

}