class PoseCategory {
  final String id;
  final String name;
  final String icon;
  final int poseCount;

  PoseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.poseCount,
  });

  factory PoseCategory.fromJson(Map<String, dynamic> json) {
    return PoseCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      poseCount: json['poseCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'poseCount': poseCount,
    };
  }
}