import 'package:flutter/material.dart';
import 'package:glamourmebusiness/blocs/language/language_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelector extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData leadingIcon;

  const LanguageSelector({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool _selectedLanguage = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(widget.leadingIcon),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        iconColor: Colors.black,
        trailing: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'En',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(width: 10),
              Switch(
                  value: _selectedLanguage,
                  onChanged: (val) {
                    setState(() {
                      _selectedLanguage = val;
                      BlocProvider.of<LanguageBloc>(context).add(
                          LanguageChangedEvent(
                              locale: Locale(val ? 'si' : 'en')));
                    });
                  }),
              const SizedBox(width: 10),
              Text(
                'සිං',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ));
  }
}
