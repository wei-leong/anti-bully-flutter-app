import 'package:apu_assignment/core/theme/sizes.dart';
import 'package:apu_assignment/features/conselor/resources/data/resource_item.dart';
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

    return Padding(
      // 这里的 padding 必须与 VideoCard 的整体外间距保持一致
      padding: const EdgeInsets.only(bottom: kDefaultPadding), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
        children: [
          // 1. 头像：添加 Padding 使其向下偏移，对齐卡片内部内容
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding), 
            child: CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                resourceItem.source.isNotEmpty ? resourceItem.source[0] : "?",
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
          ),
          
          const SizedBox(width: 12),

          // 2. 右侧卡片内容
          Expanded(
            child: Container(
              // 如果想让视觉更统一，给整个右侧卡片增加顶部 margin 或 padding
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant, 
                borderRadius: BorderRadius.circular(kDefaultRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片部分
                  imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                          imageUrl!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                        )
                      : _buildPlaceholderImage(),

                  // 文字信息部分
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resourceItem.source,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          resourceItem.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        if (resourceItem.durationOrSize.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 16, color: colorScheme.primary),
                              const SizedBox(width: 4),
                              Text(
                                resourceItem.durationOrSize,
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
          ),
        ],
      ),
    );
  }

  // 提取出的图片占位符方法，保持代码整洁
  Widget _buildPlaceholderImage() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
    );
  }
}