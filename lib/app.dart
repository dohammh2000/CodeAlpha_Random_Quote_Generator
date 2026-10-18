import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_generator/features/auth/domain/repositories/auth_repository.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/get_current_user.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_in.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_out.dart';
import 'package:random_quote_generator/features/auth/domain/usecases/sign_up.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_event.dart';
import 'package:random_quote_generator/features/auth/presentation/bloc/auth_state.dart';
import 'package:random_quote_generator/features/auth/presentation/pages/login_page.dart';
import 'package:random_quote_generator/features/quote/data/repositories/quote_repository.dart';
import 'package:random_quote_generator/features/quote/domain/repositories/quote_repository.dart'
    hide QuoteRepository;
import 'package:random_quote_generator/features/quote/presentation/pages/quote_page.dart';

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final QuoteRepository quoteRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.quoteRepository,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<QuoteRepository>.value(
      value: quoteRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          signIn: SignIn(authRepository),
          signUp: SignUp(authRepository),
          signOut: SignOut(authRepository),
          getCurrentUser: GetCurrentUser(authRepository),
        )..add(const AuthCheckRequested()),
        child: MaterialApp(
          title: 'Random Quote Generator',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          home: const AuthGate(),
        ),
      ),
    );
  }
}

/// Decides which page to show: Quote page if logged in, otherwise Login.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) return const QuotePage();
        if (state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return const LoginPage();
      },
    );
  }
}
