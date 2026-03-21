class ResourceItem {
  final String id;
  final String title;
  final String? subtitle;
  final String source;
  final String type;
  final String durationOrSize; 
  final String? imageUrl;
  final Map<String, dynamic>? content; 

  ResourceItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.source,
    required this.type,
    required this.durationOrSize,
    this.imageUrl,
    this.content,
  });

  factory ResourceItem.fromFirestore(Map<String, dynamic> data, String id) {
    return ResourceItem(
      id: id,
      title: data['title'] ?? '',
      source: data['author'] ?? data['source'] ?? '', 
      type: data['type'] ?? '',
      durationOrSize: data['displayDate'] ?? data['duration_of_learn_(ep:_5_min/_2_hours)'] ?? '',
      imageUrl: data['image'] ?? data['image_url'] ?? data['imageUrl'],
      content: data, 
    );
  }
}
  