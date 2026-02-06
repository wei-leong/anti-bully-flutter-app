import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/data/resource_item.dart';
import 'package:flutter/material.dart';

class EventPosterCard extends StatelessWidget {
  final ResourceItem resourceItem;
  // 您可以根据需要添加一个图片的URL或Asset路径
  final String? imageUrl; // 假设 ResourceItem 中没有图片URL，这里独立传入

  const EventPosterCard({
    super.key,
    required this.resourceItem,
    this.imageUrl, // 允许传入图片URL，如果没有则显示一个占位符
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding), // 提供底部间距
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant, // 浅色背景，与主题匹配
        borderRadius: BorderRadius.circular(kDefaultRadius), // 圆角
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // 阴影效果
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20, 
            child: Text(resourceItem.source[0]),
          ),
          const SizedBox(width: 12),

      Expanded(
        child: ClipRRect(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图片部分
            imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    height: 180, // 海报图片高度
                    width: double.infinity,
                    fit: BoxFit.cover, // 填充并裁剪
                    // 如果图片加载失败，显示一个占位符
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  )
                : Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300], // 占位背景色
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  ),

            // 文字信息部分
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 来源/发布者
                  Text(
                    resourceItem.source,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 标题
                  Text(
                    resourceItem.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2, // 标题最多显示两行
                    overflow: TextOverflow.ellipsis, // 超出部分显示省略号
                  ),
                  // 您可能还需要显示 durationOrSize，但对于 Event Poster 来说，这可能更像是“活动日期”或“规模”
                  // 如果 resourceItem.durationOrSize 代表活动日期，可以这样显示：
                  if (resourceItem.durationOrSize.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          resourceItem.durationOrSize, // 假设这里是日期或地点信息
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    )
        ]
      )    
    );
  }
}