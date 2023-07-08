import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String userId,
    required String email,
    required String username,
    required String password,
  }) : super(
          userId: userId,
          email: email,
          username: username,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String userId) {
    return UserModel(
      userId: userId,
      email: json["email"],
      username: json["username"],
      password: json["password"],
    );
  }
}
