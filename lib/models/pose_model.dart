class Pose {
  final String id;
  final String name;
  final String category;
  final List<String> tags;
  final String imageUrl;
  final String description;
  final String tips;

  Pose({
    required this.id,
    required this.name,
    required this.category,
    required this.tags,
    required this.imageUrl,
    required this.description,
    required this.tips,
  });

  factory Pose.fromJson(Map<String, dynamic> json) {
    return Pose(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      tips: json['tips'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'tags': tags,
      'imageUrl': imageUrl,
      'description': description,
      'tips': tips,
    };
  }
}