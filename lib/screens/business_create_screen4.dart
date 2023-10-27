import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/data/initial_opening_hour.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen5.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessCreationOpeningHours extends StatefulWidget {
  final BasicSalonDetails basicSalonDetails;
  final List<CategoryModel> selectedCategories;
  final String location;
  final LatLng lanLat;
  const BusinessCreationOpeningHours({
    super.key,
    required this.basicSalonDetails,
    required this.selectedCategories,
    required this.location,
    required this.lanLat,
  });

  @override
  State<BusinessCreationOpeningHours> createState() =>
      _BusinessCreationOpeningHoursState();
}

class _BusinessCreationOpeningHoursState
    extends State<BusinessCreationOpeningHours> {
  late List<OpeningHoursDataModel> _openingHours;

  @override
  void initState() {
    super.initState();
    _openingHours = [...openingHoursInitialData];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: _nextButton(context),
      ),
    );
  }

  Widget _dayRow(BuildContext context, {required OpeningHoursDataModel data}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color.fromARGB(255, 195, 195, 195),
          width: 2,
        ),
      ),
      child: Row(
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
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromARGB(255, 195, 195, 195),
                      width: 2,
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
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color.fromARGB(255, 195, 195, 195),
                      width: 2,
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
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_openingHours
              .where((element) => element.isOpen)
              .toList()
              .isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select at least one opening day'),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessCreationUploadImage(
                basicSalonDetails: widget.basicSalonDetails,
                selectedCategories: widget.selectedCategories,
                location: widget.location,
                lanLat: widget.lanLat,
                openingHours: _openingHours,
              ),
            ),
          );
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