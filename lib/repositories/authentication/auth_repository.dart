import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:glamourmebusiness/exceptions/auth_exceptions.dart';
import 'package:glamourmebusiness/models/user_model.dart';
import 'package:glamourmebusiness/repositories/authentication/base_auth_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection;

  @override
  Stream<auth.User?> get userStream => _firebaseAuth.userChanges();
  Stream<auth.User?> get authState => _firebaseAuth.authStateChanges();

  //User id of the current user
  @override
  String get userId => _firebaseAuth.currentUser?.uid ?? '';

  // Current user.
  @override
  auth.User? get currentUser => _firebaseAuth.currentUser;

  AuthenticationRepository(
      {auth.FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _usersCollection = FirebaseFirestore.instance.collection('users');

  /// Create a user with email and password
  @override
  Future<auth.User?> signup({
    required String name,
    required String email,
    required String password,
    required UserRole userRole,
  }) async {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser;
    }
    //Firebase Auth API to create user
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        userId: userCredential.user!.uid,
        name: name,
        email: email,
        userRole: userRole,
      );

      await addUserToFirebase(
        user: user,
      );

      return userCredential.user;
    } on auth.FirebaseAuthException catch (e) {
      developer.log('message: ${e.message}', stackTrace: e.stackTrace);
      if (e.code == 'weak-password') {
        throw WeakPasswordException(
          code: e.code,
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException(
          code: e.code,
          message: 'The account already exists for that email.',
        );
      }
      return null;
    } catch (e) {
      developer.log(e.toString());
      throw Exception(e);
    }
  }

  /// Used to sign in a user with email and password
  @override
  Future<UserModel?> signin({
    required String email,
    required String password,
  }) async {
    UserModel? user;
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final String currentUserId = userCredential.user!.uid;
      user = UserModel.fromJson(
          _usersCollection.doc(currentUserId) as Map<String, String>);
      developer.log("${_usersCollection.doc(currentUserId)}");
    } on auth.FirebaseAuthException catch (e) {
      developer.log(e.toString());
      if (e.code == 'user-not-found') {
        developer.log(level: 5, 'No user found for that email.');
        throw UserNotFoundException(
          code: e.code,
          message: 'No user found for that email.',
        );
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        developer.log(level: 5, 'Wrong password provided for that user.');
        throw InvalidLoginCredentials(
          code: e.code,
          message: 'Invalid login credentials. Please try again.',
        );
      } else if (e.code == 'too-many-requests') {
        developer.log(level: 5, 'Too many requests. Try again later.');
        throw TooManyRequestException(
          code: e.code,
          message: 'Too many requests. Try again later.',
        );
      } else {
        developer.log(level: 5, 'Invalid email provided for that user.');
        throw Exception(e.code.toString());
      }
    } catch (e) {
      developer.log(e.toString());
    }
    return user;
  }

  /// Used to sign out a user
  @override
  Future<void> signOut() async {
    developer.log("message: 'signing out'");
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Used to add a user to firestore
  @override
  Future<void> addUserToFirebase({
    required UserModel user,
  }) async {
    final doc = await _usersCollection.doc(user.userId).get();
    if (!doc.exists) {
      developer.log('user does not exist, adding user to firestore');
      await _usersCollection.doc(user.userId).set(
            user.toJson(),
          );
    }
  }
}
