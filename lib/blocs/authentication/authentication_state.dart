part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

class CreatingUserState extends AuthenticationState {
  const CreatingUserState();
}

class SignupErrorState extends AuthenticationState {
  final String errorMessage;
  const SignupErrorState(this.errorMessage);
}

class GettingUser extends AuthenticationState {
  const GettingUser();
}

class UserCreatedState extends AuthenticationState {
  final UserModel user;

  const UserCreatedState(this.user);
}

class UserRetrievedState extends AuthenticationState {
  final UserModel user;

  const UserRetrievedState(this.user);
}

class SigningInState extends AuthenticationState {
  const SigningInState();
}

class SigningInErrorState extends AuthenticationState {
  final String errorMessage;
  const SigningInErrorState(this.errorMessage);
}

class SignedInState extends AuthenticationState {
  const SignedInState();
}

//Todo: Was working here. Seems like this is no longer needed.
class CurrentUserState extends AuthenticationState {
  final UserModel? user;

  const CurrentUserState(this.user);
}
