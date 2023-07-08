import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? username;
  final String? email;
  final String? password;
  const UserEntity({
    this.userId,
    this.username,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        password,
      ];
}
