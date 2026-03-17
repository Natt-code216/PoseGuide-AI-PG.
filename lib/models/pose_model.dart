enum TagType { recommended, emerging, normal }

/// 构图类型
enum CompositionType {
  ruleOfThirds,  // 三分法
  central,       // 中心构图
  diagonal,      // 对角线构图
  leadingLine,   // 引导线
  frame,         // 框架式
  symmetry,      // 对称式
}

/// 姿势详情数据模型
class Pose {
  final String id;
  final String name;
  final String category;
  final List<String> tags;
  final String imageUrl;
  final String description;
  final String tips;
  final TagType tagType;

  // 模特与光线
  final String? model;
  final String? lighting;

  // 新增：专业摄影参数
  final String? focalLength;      // 建议焦距 (如 "50mm", "35-85mm")
  final String? aperture;         // 建议光圈 (如 "f/1.8", "f/2.8-f/4")
  final String? shutterSpeed;     // 建议快门 (如 "1/125s", "1/60s 以上")
  final String? iso;              // 建议 ISO (如 "ISO 100-400")

  // 新增：审美与构图
  final String? composition;      // 构图方式
  final String? aestheticAnalysis; // 审美分析
  final String? bodyLineGuide;    // 身体线条指导
  final String? expressionGuide;  // 表情指导
  final String? sceneSuggestion;  // 场景建议

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
    this.focalLength,
    this.aperture,
    this.shutterSpeed,
    this.iso,
    this.composition,
    this.aestheticAnalysis,
    this.bodyLineGuide,
    this.expressionGuide,
    this.sceneSuggestion,
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
      focalLength: json['focalLength'],
      aperture: json['aperture'],
      shutterSpeed: json['shutterSpeed'],
      iso: json['iso'],
      composition: json['composition'],
      aestheticAnalysis: json['aestheticAnalysis'],
      bodyLineGuide: json['bodyLineGuide'],
      expressionGuide: json['expressionGuide'],
      sceneSuggestion: json['sceneSuggestion'],
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
      'focalLength': focalLength,
      'aperture': aperture,
      'shutterSpeed': shutterSpeed,
      'iso': iso,
      'composition': composition,
      'aestheticAnalysis': aestheticAnalysis,
      'bodyLineGuide': bodyLineGuide,
      'expressionGuide': expressionGuide,
      'sceneSuggestion': sceneSuggestion,
    };
  }
}
