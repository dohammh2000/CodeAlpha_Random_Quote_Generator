import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_quote_generator/app.dart';
import 'package:random_quote_generator/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:random_quote_generator/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:random_quote_generator/features/quote/data/datasources/quote_remote_data_source.dart';
import 'package:random_quote_generator/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:random_quote_generator/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Build the "kitchen" (data layer) and hand it to the app
  final authRepository = AuthRepositoryImpl(
    AuthRemoteDataSource(FirebaseAuth.instance),
  );
  final quoteRepository = QuoteRepositoryImpl(
    QuoteRemoteDataSource(http.Client()),
  );

  runApp(
    MyApp(authRepository: authRepository, quoteRepository: quoteRepository),
  );
}
