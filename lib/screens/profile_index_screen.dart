import 'package:flutter/material.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/screens/profile_language_overview_screen.dart';
import 'package:glamourmebusiness/widgets/language_selector.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileIndexScreen extends StatelessWidget {
  const ProfileIndexScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(const SignOutEvent());
  }

  // Navigate to ProfileLanguageOverviewScreen
  // TODO To be changed later
  void _navigateToProfileLanguageOverviewScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileLanguageOverviewScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: profileNavigatorKey,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.profile)),
        body: ListView(
          children: <Widget>[
            
            
            ProfileScreenListItem(
              title: AppLocalizations.of(context)!.payments,
              leadingIcon: Icons.credit_card,
              onTapFunc: null,
              subtitle: AppLocalizations.of(context)!.paymentsDescription,
              trailingIcon: Icons.arrow_forward_ios,
            ),
            LanguageSelector(
              title: AppLocalizations.of(context)!.language,
              leadingIcon: Icons.language,
              subtitle: AppLocalizations.of(context)!.languageDescription,
            ),

            SizedBox(height: 50,),
            
            ProfileScreenListItem(
              title: AppLocalizations.of(context)!.signout,
              leadingIcon: Icons.logout,
              onTapFunc: () => _signOut(context),
              subtitle: '',
              trailingIcon: Icons.arrow_forward_ios,
              // trailingIcon: IconData(0, fontFamily: 'MaterialIcons'),
              isSignOutButton: true,
            ),
            //Sign out button
          ],
        ));
  }
}