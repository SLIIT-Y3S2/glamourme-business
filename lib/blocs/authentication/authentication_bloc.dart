import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:glamourmebusiness/exceptions/auth_exceptions.dart';
import 'package:glamourmebusiness/models/user_model.dart';
import 'package:glamourmebusiness/repositories/authentication/auth_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._authenticationRepository)
      : super(const AuthenticationInitialState()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetCurrentUserEvent>(_getUserHandler);
    on<SigninEvent>(_signinHandler);
    on<SignOutEvent>(_signOutHandler);
  }

  final AuthenticationRepository _authenticationRepository;

  // Event handler to log in with email and password
  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUserState());
    developer.log('email: ${event.email}');
    try {
      await _authenticationRepository.signup(
        name: event.name,
        email: event.email,
        password: event.password,
        userRole: event.userRole,
      );
      UserModel user = UserModel(
        userId: _authenticationRepository.userId,
        email: event.email,
        userRole: event.userRole,
        name: event.name,
      );
      emit(UserCreatedState(user));
    } on EmailAlreadyExistException catch (e) {
      emit(SignupErrorState(e.message));
    } on WeakPasswordException catch (e) {
      emit(SignupErrorState(e.message));
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }

  // Event handler to get the current user
  Future<void> _getUserHandler(
      GetCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    final currentUser = _authenticationRepository.currentUser;
    UserModel? user;
    if (currentUser != null) {
      user = UserModel(
        userId: currentUser.uid,
        name: currentUser.displayName ?? "",
        email: currentUser.email ?? "",
        userRole: UserRole.customer,
      );
    }
    developer.log('email: ${user?.email}');
    emit(CurrentUserState(user));
  }

  // Event handler to log in with email and password
  Future<void> _signinHandler(
    SigninEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const SigningInState());
    developer.log('email: ${event.email}');
    emit(const SigningInState());
    try {
      await _authenticationRepository.signin(
        email: event.email,
        password: event.password,
      );
      emit(const SignedInState());
    } on EmailAlreadyExistException catch (e) {
      emit(SigningInErrorState(e.message));
    } on InvalidLoginCredentials catch (e) {
      emit(SigningInErrorState(e.message));
    } catch (e) {
      emit(SigningInErrorState(e.toString()));
    }
  }

  // Event handler to sign out
  Future<void> _signOutHandler(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    await _authenticationRepository.signOut();
    emit(const AuthenticationInitialState());
  }
}
