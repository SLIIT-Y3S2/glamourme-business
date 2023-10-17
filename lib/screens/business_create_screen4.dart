import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/data/initial_opening_hour.dart';
import 'package:glamourmebusiness/screens/business_create_screen2.dart';

class BusinessCreationOpeningHours extends StatefulWidget {
  const BusinessCreationOpeningHours({super.key});

  @override
  State<BusinessCreationOpeningHours> createState() =>
      _BusinessCreationOpeningHoursState();
}

class _BusinessCreationOpeningHoursState
    extends State<BusinessCreationOpeningHours> {
  late List<CustomCheckBoxOpeningHours> _openingHours;

  @override
  void initState() {
    super.initState();
    _openingHours = [...openingHours];
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
        padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: _nextButton(context),
      ),
    );
  }

  Widget _dayRow(BuildContext context,
      {required CustomCheckBoxOpeningHours data}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: data.isChecked,
            onChanged: (value) {
              setState(() {
                data.isChecked = value!;
              });
            },
          ),
          Text(
            data.day.day,
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
                    initialTime: data.day.openingTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );
                  if (picked != null && picked != data.day.openingTime) {
                    setState(() {
                      data.day.openingTime = picked;
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
                    '${data.day.openingTime.hour}:${data.day.openingTime.minute} ${data.day.openingTime.period == DayPeriod.am ? 'AM' : 'PM'}',
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
                    initialTime: data.day.closingTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  );
                  if (picked != null && picked != data.day.closingTime) {
                    setState(() {
                      data.day.closingTime = picked;
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
                    '${data.day.closingTime.hour}:${data.day.closingTime.minute} ${data.day.closingTime.period == DayPeriod.am ? 'AM' : 'PM'}',
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
        onPressed: () {},
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

class CustomCheckBoxOpeningHours {
  final OpeningTimeData day;
  bool isChecked;

  CustomCheckBoxOpeningHours(this.day, this.isChecked);
}

class OpeningTimeData {
  final String day;
  TimeOfDay openingTime;
  TimeOfDay closingTime;

  OpeningTimeData({
    required this.day,
    required this.openingTime,
    required this.closingTime,
  });
}
