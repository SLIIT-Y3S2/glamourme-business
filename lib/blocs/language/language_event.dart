part of 'language_bloc.dart';

class LanguageEvent {
  const LanguageEvent();
}

class LanguageChangedEvent extends LanguageEvent {
  final Locale locale;

  const LanguageChangedEvent({required this.locale});
}
