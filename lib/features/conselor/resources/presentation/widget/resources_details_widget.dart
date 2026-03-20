import 'dart:typed_data';
import 'package:apu_assignment/features/Images/data/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResourceDetails extends StatelessWidget {
  final dynamic resourceItem; 
  
  const ResourceDetails({super.key, required this.resourceItem});

  @override
  Widget build(BuildContext context) {
    final type = resourceItem.type.toLowerCase();
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const Gap(12),
          // 顶部装饰条
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTypeLabel(type),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 公共部分：标题和作者
                  Text(resourceItem.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const Gap(8),
                  _buildMetaInfo("Posted by ${resourceItem.source}", Icons.person_outline),
                  const Gap(20),
                  
    
                  ...buildTypeContent(context, type),
                  
                  const Gap(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 根据类型返回不同的 Widget 列表
  List<Widget> buildTypeContent(BuildContext context, String type) {
    // 统一转小写，防止匹配失败
    final normalizedType = type.toLowerCase();
    final Uint8List? imageBytes = ImagesProvider.decodeBase64(resourceItem.content['image']);
    
    switch (normalizedType) {
      case 'videos':
        return [
          const Text("Video Link", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(8),
          // 使用 SelectableText 方便用户复制链接
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              resourceItem.content['video_url_(youtube_only)'] ?? "No Link Provided", 
              style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)
            ),
          ),
          const Gap(20),
          const Text("Description", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(8),
          Text(resourceItem.content['content'] ?? "No description available.", style: const TextStyle(fontSize: 15)),
        ];

      case 'articles':
        return [
            if (imageBytes != null) ...[
              // 2. 设置 Container 来限制图片展示区域
              Container(
                width: double.infinity, // 占满屏幕宽度
                height: 500,           
                margin: const EdgeInsets.only(bottom: 20), // 间距
                decoration: BoxDecoration(
                  color: Colors.grey[100], // 图片以外区域的背景色，方便查看效果
                  borderRadius: BorderRadius.circular(12),
                ),
                
                // 3. 裁剪超出圆角的部分
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    imageBytes,
                    // ✨ 关键属性：完整展示且不拉伸 ✨
                    fit: BoxFit.contain, 
                    
                    // 当 fit 为 contain 时，Image 的 width/height 属性是作为容器边界
                    width: double.infinity,
                    height: 200, 

                    // 错误处理占位符
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ],

          _buildInfoRow(
            "Duration (Minute)", 
            resourceItem.content['duration_of_learn_(ep:_5_min/_2_hours)'] ?? "There is no reference duration", 
            Icons.timeline
          ),
          const Gap(12),
          
          const Text("Articles", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.grey
            )),
          const Gap(12),

          Text(
            resourceItem.content['content'] ?? "No content available.", 
            style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87)
          ),
        ];

      case 'news':
        return [
          // News 展示内容和副标题
          if (resourceItem.subtitle != null) ...[
            Text(
              resourceItem.subtitle!, 
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey)
            ),
            const Gap(16),
          ],

          if (imageBytes != null) ...[
            // 2. 设置 Container 来限制图片展示区域
            Container(
              width: double.infinity, // 占满屏幕宽度
              height: 500,           
              margin: const EdgeInsets.only(bottom: 20), // 间距
              decoration: BoxDecoration(
                color: Colors.grey[100], // 图片以外区域的背景色，方便查看效果
                borderRadius: BorderRadius.circular(12),
              ),
              
              // 3. 裁剪超出圆角的部分
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  imageBytes,
                  // ✨ 关键属性：完整展示且不拉伸 ✨
                  fit: BoxFit.contain, 
                  
                  // 当 fit 为 contain 时，Image 的 width/height 属性是作为容器边界
                  width: double.infinity,
                  height: 200, 

                  // 错误处理占位符
                  errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
          ],

          _buildInfoRow(
            "Date", 
            resourceItem.content['date'] ?? "Date to be confirmed", 
            Icons.calendar_month_rounded
          ),
          const Gap(24),

          _buildInfoRow(
            "Sources", 
            resourceItem.content['source'] ?? "The information no sources", 
            Icons.house_outlined
          ),
          const Gap(24),

          const Text("Content", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.grey
            )),
          const Gap(12),

          Text(
            resourceItem.content['content'] ?? "There is nothings", 
            style: const TextStyle(fontSize: 16, height: 1.5)
          ),
        ];

      case 'events':
        return [

          if (imageBytes != null) ...[
            // 2. 设置 Container 来限制图片展示区域
            Container(
              width: double.infinity, // 占满屏幕宽度
              height: 500,           
              margin: const EdgeInsets.only(bottom: 20), // 间距
              decoration: BoxDecoration(
                color: Colors.grey[100], // 图片以外区域的背景色，方便查看效果
                borderRadius: BorderRadius.circular(12),
              ),
              
              // 3. 裁剪超出圆角的部分
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  imageBytes,
                  // ✨ 关键属性：完整展示且不拉伸 ✨
                  fit: BoxFit.contain, 
                  
                  // 当 fit 为 contain 时，Image 的 width/height 属性是作为容器边界
                  width: double.infinity,
                  height: 200, 

                  // 错误处理占位符
                  errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
          ],
          // 1. 活动地点展示
          _buildInfoRow(
            "Location", 
            resourceItem.content['location'] ?? "Venue to be announced", 
            Icons.location_on_rounded
          ),
          const Gap(16),
          
          // 2. 活动日期展示
          _buildInfoRow(
            "Event Date", 
            resourceItem.content['date'] ?? "Date to be confirmed", 
            Icons.calendar_month_rounded
          ),
          const Gap(24),

          _buildInfoRow(
            "Start Time", 
            resourceItem.content['start_time'] ?? "Time to be confirmed", 
            Icons.lock_clock_outlined
          ),
          const Gap(24),

          _buildInfoRow(
            "End Time", 
            resourceItem.content['end_time'] ?? "Time to be confirmed", 
            Icons.lock_clock
          ),
          const Gap(24),
          
          const Text(
            "Register", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14)
          ),
          const Gap(4),

          Text(
          resourceItem.content['register_link'] ?? "Scan Poster QR for Register",
            style: const TextStyle(
              fontSize: 16, 
              height: 1.5, 
              color: Colors.black87
            ),
          ),
          const Gap(12),

          // 3. 分割线或小标题
          const Text(
            "Event Details", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14)
          ),
          const Gap(4),
          
          // 4. 活动描述正文
          Text(
            resourceItem.content['content'] ?? "No additional description provided for this event.",
            style: const TextStyle(
              fontSize: 16, 
              height: 1.5, 
              color: Colors.black87
            ),
          ),
        ];

      default:
        return [
          const Text("Information", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(12),
          Text(resourceItem.content.toString()),
        ];
    }
  }

  String _getTypeLabel(String type) => type.toUpperCase();

  Widget _buildMetaInfo(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const Gap(6),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }
}