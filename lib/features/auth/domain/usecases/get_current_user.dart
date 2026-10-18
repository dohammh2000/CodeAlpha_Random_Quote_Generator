import 'package:random_quote_generator/features/auth/domain/entities/user_entity.dart';
import 'package:random_quote_generator/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser(this.repository);

  UserEntity? call() => repository.getCurrentUser();
}
