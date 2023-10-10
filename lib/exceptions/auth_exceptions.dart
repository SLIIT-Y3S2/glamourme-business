class AuthException implements Exception {
  final String code;
  final String message;

  AuthException({required this.code, required this.message});
}

class WeakPasswordException extends AuthException {
  WeakPasswordException({required super.code, required super.message});
}

class EmailAlreadyExistException extends AuthException {
  EmailAlreadyExistException({required super.code, required super.message});
}

class UserNotFoundException extends AuthException {
  UserNotFoundException({required super.code, required super.message});
}

class InvalidLoginCredentials extends AuthException {
  InvalidLoginCredentials({required super.code, required super.message});
}

class TooManyRequestException extends AuthException {
  TooManyRequestException({required super.code, required super.message});
}
