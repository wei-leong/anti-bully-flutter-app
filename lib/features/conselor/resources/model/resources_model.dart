class ResourceItem {
  final String title;
  final String? subtitle;
  final String source;
  final String type;
  final String durationOrSize; 
  final String? imageUrl;
  final Map<String, dynamic>? content; 

  ResourceItem({
    required this.title,
    this.subtitle,
    required this.source,
    required this.type,
    required this.durationOrSize,
    this.imageUrl,
    this.content,
  });

  factory ResourceItem.fromFirestore(Map<String, dynamic> json) {
    return ResourceItem(
      title: json['title'] ?? '',
      source: json['author'] ?? json['source'] ?? '', 
      type: json['type'] ?? '',
      durationOrSize: json['displayDate'] ?? json['duration_of_learn_(ep:_5_min/_2_hours)'] ?? '',
      imageUrl: json['image_url'] ?? json['imageUrl'],
      content: json, 
    );
  }
}
  