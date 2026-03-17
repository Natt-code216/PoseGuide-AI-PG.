class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String? phone;
  final String? gender; // 'male', 'female', 'other'
  final String? bio;
  final bool isVip;
  final DateTime? vipExpireTime;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.phone,
    this.gender,
    this.bio,
    this.isVip = false,
    this.vipExpireTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      phone: json['phone'],
      gender: json['gender'],
      bio: json['bio'],
      isVip: json['isVip'] ?? false,
      vipExpireTime: json['vipExpireTime'] != null
          ? DateTime.parse(json['vipExpireTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'phone': phone,
      'gender': gender,
      'bio': bio,
      'isVip': isVip,
      'vipExpireTime': vipExpireTime?.toIso8601String(),
    };
  }
}