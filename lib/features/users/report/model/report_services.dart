import 'package:cloud_firestore/cloud_firestore.dart';

class ReportServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveReport(Map<String,dynamic> rawData) async {
    await _db.collection('reports').add(rawData);
  }
}