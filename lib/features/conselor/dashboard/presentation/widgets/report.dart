import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String location;
  final String description;
  final String status;
  final int urgentlevel;
  final VoidCallback? onTap;

  const ReportCard({
    super.key,
    required this.location,
    required this.description,
    required this.status,
    required this.urgentlevel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //Urgent color - low, medium and high three level
    Color urgentColor;
    String urgentText;
    switch (urgentlevel) {
      case 3:
        urgentColor = Colors.red;
        urgentText = "High Priority";
        break;
      case 2:
        urgentColor = Colors.orange;
        urgentText = "Medium Priority";
        break;
      case 1:
      default:
        urgentColor = Colors.cyan;
        urgentText = "Low Priority";
        break;
    }

    //Status color - Inprogress, end and pending 3 level
    Color statusColor = status == "In-progress" ? Colors.blue : 
                        status == "End" ? Colors.green : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: urgentColor.withOpacity(0.5), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
              ],
            ),
            const SizedBox(height: 12), 
            //location
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: urgentColor),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // description
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            // status and view button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onTap,
                  child: const Text("View Details"),
                ),
              ],
            ),
          ], // Column children ends
        ),
      ),
    );
  }
}