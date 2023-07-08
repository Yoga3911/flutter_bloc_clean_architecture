import 'package:hive_flutter/hive_flutter.dart';

import '../user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final data = reader.readList();

    return UserModel(
      userId: data[0],
      email: data[1],
      username: data[2],
      password: data[3],
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeList([
      obj.userId,
      obj.email,
      obj.username,
      obj.password,
    ]);
  }
}
