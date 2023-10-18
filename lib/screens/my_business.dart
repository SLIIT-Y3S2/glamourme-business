import 'package:flutter/material.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/profile_screen_list_item.dart';
import 'package:glamourmebusiness/screens/my_business_service_1.dart';

class MyBusiness extends StatelessWidget {
  const MyBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Business'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: green1,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Handle item 1 click here.
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle item 2 click here.
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            ProfileScreenListItem(
              title: 'Services',
              leadingIcon: Icons.favorite_outline,
              onTapFunc: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MybusinessServiceScreen1()),
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
              subtitle: 'View a list of clients you have served, Leave feedback',
              trailingIcon: Icons.arrow_forward_ios,
            ),
          ],
        ));
  }
}
