import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';
import 'package:glamourmebusiness/screens/my_business_services_screen.dart';

class MyBusiness extends StatefulWidget {
  const MyBusiness({super.key});

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
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
                    child: Column(
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
                  )
                : const Text('loading'),
          ),
          body: ListView(
            children: <Widget>[
              ProfileScreenListItem(
                title: 'Services',
                leadingIcon: Icons.favorite_outline,
                onTapFunc: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MyBusinessServices()),
                  );
                },
                subtitle: 'Add services, Manage all the services you offer',
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: 'Opening Hours',
                leadingIcon: Icons.access_time,
                onTapFunc: null,
                subtitle: 'Adjust your opening hours',
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: 'Payments',
                leadingIcon: Icons.credit_card,
                onTapFunc: null,
                subtitle: 'Payment methods, Transaction History',
                trailingIcon: Icons.arrow_forward_ios,
              ),
              ProfileScreenListItem(
                title: 'Your Clients',
                leadingIcon: Icons.people_outline,
                onTapFunc: null,
                subtitle:
                    'View a list of clients you have served, Leave feedback',
                trailingIcon: Icons.arrow_forward_ios,
              ),
            ],
          ),
        );
      },
    );
  }
}
