import 'package:apu_assignment/features/admin/admin_dashboard/ui/widgets/view_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apu_assignment/features/conselor/resources/data/resources_provider.dart'; 

class resourcesmanagement extends ConsumerWidget {
  const resourcesmanagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 💡 监听你在上一步创建的 pendingResourcesProvider
    final resourcesAsync = ref.watch(pendingResourcesProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Poster Management", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: resourcesAsync.when(
        data: (resources) {
          // 💡 处理空状态，参考 Dashboard 的逻辑
          if (resources.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: colorScheme.outline),
                  const SizedBox(height: 16),
                  const Text("No pending posters to review"),
                ],
              ),
            );
          }

          // 💡 列表展示：参考 image_fc8635.png 的简洁样式
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: resources.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final resource = resources[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                // 💡 仿照 image_fc8635.png 的头像和主标题布局
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.person, color: colorScheme.onPrimaryContainer),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        resource.source, // 作者名
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      resource.durationOrSize, // 日期
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    resource.title, // 资源标题/内容简述
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                onTap: () {
                  // 💡 点击跳转详情或弹出审批弹窗
                  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // 允许高度自定义
                  backgroundColor: Colors.transparent, // 保持圆角效果
                  builder: (context) => FractionallySizedBox(
                    heightFactor: 0.9, // 设置显示高度为屏幕的 90%
                    child: ResourceDetails(resourceItem: resource), // 💡 传入当前的资源对象
                  ),
                );
                },
              );
            },
          );
        },
        // 💡 加载中状态
        loading: () => const Center(child: CircularProgressIndicator()),
        // 💡 错误状态
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
