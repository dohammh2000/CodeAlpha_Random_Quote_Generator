import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_quote_generator/core/error/app_exception.dart';
import 'package:random_quote_generator/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  UserModel? getCurrentUser() {
    final user = firebaseAuth.currentUser;
    return user == null ? null : UserModel.fromFirebase(user);
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(result.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_messageFor(e.code));
    }
  }

  Future<UserModel> signUp(String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(result.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_messageFor(e.code));
    }
  }

  Future<void> signOut() => firebaseAuth.signOut();

  // Turns Firebase's technical error codes into friendly messages
  String _messageFor(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
