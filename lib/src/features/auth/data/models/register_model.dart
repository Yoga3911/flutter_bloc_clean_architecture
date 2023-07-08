import '../../domain/entities/user_entity.dart';

class RegisterModel extends UserEntity {
  const RegisterModel({
    required String username,
    required String email,
    required String password,
  }) : super(
          username: username,
          email: email,
          password: password,
        );

  RegisterModel copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return RegisterModel(
      username: username ?? (this.username ?? ""),
      email: email ?? (this.email ?? ""),
      password: password ?? (this.password ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "password": password,
    };
  }
}
