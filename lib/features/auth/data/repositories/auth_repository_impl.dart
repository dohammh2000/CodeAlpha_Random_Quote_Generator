import 'package:random_quote_generator/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:random_quote_generator/features/auth/domain/entities/user_entity.dart';
import 'package:random_quote_generator/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  UserEntity? getCurrentUser() => dataSource.getCurrentUser();

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) => dataSource.signIn(email, password);

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
  }) => dataSource.signUp(email, password);

  @override
  Future<void> signOut() => dataSource.signOut();
}
