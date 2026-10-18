import 'package:random_quote_generator/features/auth/domain/entities/user_entity.dart';
import 'package:random_quote_generator/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;
  SignUp(this.repository);

  Future<UserEntity> call({required String email, required String password}) =>
      repository.signUp(email: email, password: password);
}
