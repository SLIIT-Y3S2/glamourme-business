import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  String selectedTime = '';

  void selectService(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeOption(
            time: "15 min",
            isSelected: selectedTime == "15 min",
            onTap: () {
              selectService("15 min");
            },
          ),
          TimeOption(
            time: "20 min",
            isSelected: selectedTime == "20 min",
            onTap: () {
              selectService("20 min");
            },
          ),
          TimeOption(
            time: "30 min",
            isSelected: selectedTime == "30 min",
            onTap: () {
              selectService("30 min");
            },
          ),
          TimeOption(
            time: "45 min",
            isSelected: selectedTime == "45 min",
            onTap: () {
              selectService("45 min");
            },
          ),
        ],
      );
    
  }
}

class TimeOption extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  TimeOption({
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.green : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
           
            
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
