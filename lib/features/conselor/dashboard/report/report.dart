import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String location;
  final String date;
  final String description;
  final String status; 
  final int urgentlevel;
  final VoidCallback? onTap;

  const ReportCard({
    super.key,
    required this.location,
    required this.date,
    required this.description,
    required this.status,
    required this.urgentlevel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color urgentColor;
    String urgentText;
    switch (urgentlevel) {
      case 3:
        urgentColor = Colors.red;
        urgentText = "High Priority";
        break;
      case 2:
        urgentColor = Colors.orange; // 黄色/橙色
        urgentText = "Medium Priority";
        break;
      case 1:
      default:
        urgentColor = Colors.cyan; // 青色
        urgentText = "Low Priority";
        break;
    }

    Color statusColor = status == "In-progress" ? Colors.blue : 
                        status == "End" ? Colors.green : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      // 使用不同颜色的边框来区分等级
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: urgentColor.withOpacity(0.5), width: 2), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 等级标签
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: urgentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    urgentText,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(date, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 12),
            // 地点
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: urgentColor),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 24),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status = $status",
                style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)
                ),
                TextButton(
                  onPressed: onTap,
                  child: const Text("View Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}