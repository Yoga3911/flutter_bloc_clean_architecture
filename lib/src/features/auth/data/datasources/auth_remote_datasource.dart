import '../../../../core/api/api_url.dart';
import '../../../../core/constants/error_message.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/user_model.dart';

sealed class AuthRemoteDataSource {
  Future<UserModel> login(LoginModel model);
  Future<void> logout();
  Future<void> register(RegisterModel model);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(LoginModel model) async {
    try {
      final user = await _getUserByEmail(model.email ?? "");

      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> register(RegisterModel model) async {
    try {
      final user = await _getUserByEmail(model.email ?? "");
      if (user.email == model.email) {
        throw DuplicateEmailException();
      }

      return;
    } on EmptyException {
      await ApiUrl.users.add(model.toMap());
    } on DuplicateEmailException {
      rethrow;
    } catch (e) {
      logger.e(e);
      throw ServerException();
    }
  }

  Future<UserModel> _getUserByEmail(String email) async {
    try {
      final result = await ApiUrl.users.where("email", isEqualTo: email).get();
      final doc = result.docs.first;
      final user = UserModel.fromJson(doc.data(), doc.id);

      return user;
    } catch (e) {
      if (e.toString() == noElement) {
        throw EmptyException();
      }
      logger.e(e);
      throw ServerException();
    }
  }
}
