import 'package:apu_assignment/features/conselor/dashboard/model/report_model.dart';
import 'package:apu_assignment/features/conselor/resources/model/resources_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ReportModel>> fetchReports(String userUid) {
    return _firestore
        .collection('reports')
        .where('assignedCounselorId', isEqualTo: userUid)
        // 使用 whereIn 同时筛选多个状态
        .where('reportStatus', whereIn: ['InProgress', 'Pending'])
        .snapshots()
        .map((snapshot) {
          // 将 Firestore 的 QuerySnapshot 转换为你的 Model 列表
          return snapshot.docs.map((doc) {
            return ReportModel.fromFirestore(doc); 
          }).toList();
        });
  }
// Mock Data
    // await Future.delayed(const Duration(milliseconds: 500)); 
    
    // final List<Map<String, dynamic>> rawData = [
    //   {
    //   "location": "Library Hall A",
    //   "date": "Jan 12, 2026",
    //   "description": "Student reported verbal harassment near the entrance.",
    //   "status": "In-progress",
    //   "Level": 3
    // },
    // {
    //   "location": "Cafeteria",
    //   "date": "Jan 11, 2026",
    //   "description": "Anonymity case: Victim fears retaliation after a group incident.",
    //   "status": "Pending",
    //   "Level": 2
    // },
    // {
    //   "location": "Cafeteria aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    //   "date": "Jan 11, 2026",
    //   "description": "Anonymity case: Victim fears retaliation after a group incident ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss.",
    //   "status": "End",
    //   "Level": 1
    // },
    // ];

    // return rawData.map((e) => ReportModel.fromMap(e)).toList();
  }

