
class UserModel {
  final String email;
  final String name;
  final String type;
  final String fcmToken;

  UserModel({
    required this.email,
    required this.name,
    required this.type,
    required this.fcmToken,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
      fcmToken: map['fcmToken'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'type': type,
      'fcmToken': fcmToken,
    };
  }
}