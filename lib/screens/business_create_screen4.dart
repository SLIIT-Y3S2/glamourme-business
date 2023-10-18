import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/data/initial_opening_hour.dart';
import 'package:glamourmebusiness/globals.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';
import 'package:glamourmebusiness/screens/main_screen.dart';

class BusinessCreationOpeningHours extends StatefulWidget {
  final BasicSalonDetails basicSalonDetails;
  final List<CategoryModel> selectedCategories;
  final String location;
  const BusinessCreationOpeningHours({
    super.key,
    required this.basicSalonDetails,
    required this.selectedCategories,
    required this.location,
  });

  @override
  State<BusinessCreationOpeningHours> createState() =>
      _BusinessCreationOpeningHoursState();
}

class _BusinessCreationOpeningHoursState
    extends State<BusinessCreationOpeningHours> {
  late List<OpeningHoursDataModel> _openingHours;

  String? _salonOwnerId;

  @override
  void initState() {
    super.initState();
    _openingHours = [...openingHoursInitalData];
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
  }

  void _onSubmit() {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;

    if (authState is CurrentUserState) {
      if (authState.user == null) {
        developer.log('user is null', name: 'user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to continue'),
          ),
        );
        return;
      } else {
        _salonOwnerId = authState.user!.userId;
        developer.log(authState.user!.userId, name: 'userId');
      }
    }

    BlocProvider.of<SalonBloc>(context).add(
      CreateSalonEvent(
        salon: SalonModel.init(
          salonName: widget.basicSalonDetails.salonName,
          website: widget.basicSalonDetails.website,
          salonType: widget.basicSalonDetails.salonType,
          categories: widget.selectedCategories,
          location: widget.location,
          openingHours: _openingHours,
          salonOwnerId: _salonOwnerId!,
          contactNumber: '',
          description: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBloc, SalonState>(
      listener: (context, state) {
        if (state is SalonCreatedState) {
          // globalNavigatorKey.currentState!.pushReplacementNamed('/main');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Business Created!'),
            ),
          );
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            // title: const Text('Create Business'),
            ),
        body: Container(
          padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Opening Hours?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1C1C28),
                  fontSize: 23,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  height: 0,
                  letterSpacing: -0.46,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _openingHours.length,
                  itemBuilder: (context, index) {
                    return _dayRow(context, data: _openingHours[index]);
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: _nextButton(context),
        ),
      ),
    );
  }

  Widget _dayRow(BuildContext context, {required OpeningHoursDataModel data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          value: data.isOpen,
          onChanged: (value) {
            setState(() {
              data.isOpen = value!;
            });
          },
        ),
        Text(
          data.day,
          style: const TextStyle(
            color: Color(0xFF1C1C28),
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 0,
            letterSpacing: -0.32,
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: data.openingTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (picked != null && picked != data.openingTime) {
                  setState(() {
                    data.openingTime = picked;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF1C1C28),
                    width: 1,
                  ),
                ),
                width: 90,
                alignment: Alignment.center,
                child: Text(
                  '${data.openingTime.hour}:${data.openingTime.minute} ${data.openingTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                  style: const TextStyle(
                    color: Color(0xFF1C1C28),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "-",
              style: TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 16,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: -0.32,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: data.closingTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (picked != null && picked != data.closingTime) {
                  setState(() {
                    data.closingTime = picked;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xFF1C1C28),
                    width: 1,
                  ),
                ),
                width: 90,
                alignment: Alignment.center,
                child: Text(
                  '${data.closingTime.hour}:${data.closingTime.minute} ${data.closingTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                  style: const TextStyle(
                    color: Color(0xFF1C1C28),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: -0.32,
                  ),
                ),
              ),
            ),
          ],
        ),
        // _dayText(context),
        // _timeRow(context),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _onSubmit();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(signupScreenColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// 