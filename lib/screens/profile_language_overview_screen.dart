import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileLanguageOverviewScreen extends StatelessWidget {
  const ProfileLanguageOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
                  child: Text(
                    AppLocalizations.of(context)!.language,
                    style: const TextStyle(
                      color: Color(0xFF1C1C28),
                      fontSize: 23,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: -0.38,
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                    child: TextButton(
                        onPressed: () {
                          // _localization.translate('en');
                        },
                        child: const Text(
                          'English',
                          style: TextStyle(
                            color: Color(0xFF1C1C28),
                            fontSize: 19,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: -0.38,
                          ),
                        )))),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 0, 0),
                  child: TextButton(
                      onPressed: () {
                        // _localization.translate('si');
                      },
                      child: const Text(
                        'සිංහල',
                        style: TextStyle(
                          color: Color(0xFF1C1C28),
                          fontSize: 19,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -0.38,
                        ),
                      )),
                )),
          ],
        ),
      ]),
    );
  }
}
