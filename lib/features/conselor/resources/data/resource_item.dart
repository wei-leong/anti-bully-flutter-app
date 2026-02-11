class ResourceItem {
  final String title;
  final String source;
  final String type;
  final String durationOrSize; // 02:00 / 2 MB
  final String? imageUrl;

  ResourceItem({
    required this.title,
    required this.source,
    required this.type,
    required this.durationOrSize,
    this.imageUrl,
  });
}