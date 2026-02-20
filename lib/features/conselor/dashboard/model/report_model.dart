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

  // 从 Map 转换为 Model，并提供安全默认值
  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      location: map['location'] ?? 'Unknown',
      date: map['date'] ?? 'N/A',
      description: map['description'] ?? '',
      status: map['status'] ?? 'Pending',
      urgentLevel: map['Level'] ?? 1, // 修正大小写，防止 Null 报错
    );
  }
}