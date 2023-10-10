import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:glamourmebusiness/models/user_model.dart';

abstract class BaseAuthenticationRepository {
  Stream<auth.User?> get userStream;

  String get userId;

  auth.User? get currentUser;

  /// This method is used to create a user with email and password
  Future<auth.User?> signup({
    required String name,
    required String email,
    required String password,
    required UserRole userRole,
  });

  /// This method is used to sign in a user with email and password
  Future<UserModel?> signin({
    required String email,
    required String password,
  });

  /// This method is used to sign out a user
  Future<void> signOut();

  Future<void> addUserToFirebase({required UserModel user});
}
