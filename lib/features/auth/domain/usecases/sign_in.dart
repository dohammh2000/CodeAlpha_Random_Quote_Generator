import 'package:random_quote_generator/features/auth/domain/entities/user_entity.dart';
import 'package:random_quote_generator/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;
  SignIn(this.repository);

  Future<UserEntity> call({required String email, required String password}) =>
      repository.signIn(email: email, password: password);
}
