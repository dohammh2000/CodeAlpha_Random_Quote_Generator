import 'package:random_quote_generator/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getCurrentUser();
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> signUp({required String email, required String password});
  Future<void> signOut();
}
