import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';
import 'package:glamourmebusiness/screens/my_business_service_1.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SalonBloc>(context).add(GetSalonEvent());
    return Scaffold(
        appBar: AppBar(
          title: Text('My Business'),
        ),
        body: BlocBuilder<SalonBloc, SalonState>(
          builder: (context, state) {
            return ListView(
              children: <Widget>[
                if (state is SalonLoaded) Text(state.salon.salonName),
                ProfileScreenListItem(
                  title: 'Services',
                  leadingIcon: Icons.favorite_outline,
                  onTapFunc: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MybusinessServiceScreen1()),
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
            );
          },
        ));
  }
}
