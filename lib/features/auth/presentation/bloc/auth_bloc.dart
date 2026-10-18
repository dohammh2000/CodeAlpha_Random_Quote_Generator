import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_generator/core/error/app_exception.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/get_current_user.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_in.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_out.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_up.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_event.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.getCurrentUser,
  }) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onCheck);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
  }

  void _onCheck(AuthCheckRequested event, Emitter<AuthState> emit) {
    final user = getCurrentUser();
    emit(user != null ? Authenticated(user) : const Unauthenticated());
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final user = await signIn(email: event.email, password: event.password);
      emit(Authenticated(user));
    } on AppException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = await signUp(email: event.email, password: event.password);
      emit(Authenticated(user));
    } on AppException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await signOut();
    emit(const Unauthenticated());
  }
}
