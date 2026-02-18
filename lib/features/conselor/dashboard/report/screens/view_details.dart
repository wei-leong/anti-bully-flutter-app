import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ViewDetails extends StatelessWidget {
  final Map<String, dynamic> data; // 接收传进来的 report 数据

  const ViewDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // 这里的颜色逻辑可以复用你 ReportCard 里的逻辑
    final Color statusColor = data['status'] == "In-progress" ? Colors.blue : 
                             data['status'] == "End" ? Colors.green : Colors.orange;

    return Container(
      // 这里的 decoration 确保了弹窗的圆角
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // 顶部的控制条
          const Gap(12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // 顶部标题栏
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // 详细内容区域
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection("Location", data['location'], Icons.location_on, Colors.redAccent),
                  const Gap(20),
                  _buildInfoSection("Date Reported", data['date'], Icons.calendar_today, Colors.blue),
                  const Gap(20),
                  _buildInfoSection("Current Status", data['status'], Icons.hourglass_bottom, statusColor),
                  const Gap(24),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const Gap(8),
                  Text(
                    data['description'],
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const Gap(40),
                  
                  // 底部操作按钮
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: () {
                        // 处理逻辑
                      },
                      icon: const Icon(Icons.edit_note),
                      label: const Text("Update Status"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 辅助方法：构建信息板块
  Widget _buildInfoSection(String title, String content, IconData icon, Color iconColor) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start, // 关键：如果文字换行，图标对齐顶部
    children: [
      Icon(icon, color: iconColor, size: 20),
      const Gap(12),
      // 使用 Expanded 让 Column 占据剩余的所有横向空间
      Expanded( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                height: 1.3, // 增加行高，防止文字挤在一起
              ),
              // 如果你希望地点太长时自动换行，不要设置 maxLines
              // 如果你只想显示两行，多了省略，可以解除下面两行的注释：
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      )
    ],
  );
}
}