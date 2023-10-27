part of 'language_bloc.dart';

sealed class LanguageState {
  const LanguageState();
}

final class LanguageInitial extends LanguageState {}

final class LanguageChanged extends LanguageState {
  final Locale locale;

  const LanguageChanged({required this.locale});
}
