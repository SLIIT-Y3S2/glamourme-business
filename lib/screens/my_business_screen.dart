import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';
import 'package:glamourmebusiness/screens/my_business_services_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  @override
  void initState() {
    BlocProvider.of<SalonBloc>(context).add(const GetSalonEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalonBloc, SalonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: (state is SalonLoaded)
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.salon.salonName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                ),
                                Text(
                                  " ${state.salon.location}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const Text('loading'),
          ),
          body: ListView(
            children: <Widget>[
              ProfileScreenListItem(
                title: AppLocalizations.of(context)!.services,
                leadingIcon: Icons.favorite_outline,
                onTapFunc: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MyBusinessServices()),
                  );
                },
                subtitle: AppLocalizations.of(context)!.servicesSentence,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: AppLocalizations.of(context)!.openingHours,
                leadingIcon: Icons.access_time,
                onTapFunc: null,
                subtitle: AppLocalizations.of(context)!.openingHoursSentence,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: AppLocalizations.of(context)!.payments,
                leadingIcon: Icons.credit_card,
                onTapFunc: null,
                subtitle: AppLocalizations.of(context)!.paymentSentence,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: AppLocalizations.of(context)!.yourclients,
                leadingIcon: Icons.people_outline,
                onTapFunc: null,
                subtitle: AppLocalizations.of(context)!.yourclientSentence,
                trailingIcon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        );
      },
    );
  }
}
