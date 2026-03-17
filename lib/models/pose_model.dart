enum TagType { recommended, emerging, normal }

class Pose {
  final String id;
  final String name;
  final String category;
  final List<String> tags;
  final String imageUrl;
  final String description;
  final String tips;
  final TagType tagType;
  final String? model;
  final String? lighting;

  Pose({
    required this.id,
    required this.name,
    required this.category,
    required this.tags,
    required this.imageUrl,
    required this.description,
    required this.tips,
    this.tagType = TagType.normal,
    this.model,
    this.lighting,
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
      tagType: _parseTagType(json['tagType']),
      model: json['model'],
      lighting: json['lighting'],
    );
  }

  static TagType _parseTagType(String? tagType) {
    switch (tagType) {
      case 'recommended':
        return TagType.recommended;
      case 'emerging':
        return TagType.emerging;
      default:
        return TagType.normal;
    }
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
      'tagType': tagType.name,
      'model': model,
      'lighting': lighting,
    };
  }
}
