import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';

class SelectTime extends StatefulWidget {
  final void Function(int totalMin) notifyParent;
  const SelectTime({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  int selectedHour = 0;
  int selectedMinute = 0;

  Map<int, String> hoursList = {
    0: "00",
    1: "01",
    2: "02",
    3: "03",
    4: "04",
    5: "05",
    6: "06",
    7: "07",
    8: "08",
    9: "09",
    10: "10",
    11: "11",
    12: "12"
  };
  Map<int, String> minutesList = {
    0: "00",
    15: "15",
    30: "30",
    45: "45",
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: green1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton(
              elevation: 0,
              underline: Container(alignment: Alignment.center, height: 0),
              value: selectedHour,
              items: hoursList.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text(e.value), const Text("hrs")],
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    widget.notifyParent(value * 60 + selectedMinute);
                    selectedHour = value;
                  }
                });
              }),
        ),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: green1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton(
              value: selectedMinute,
              elevation: 0,
              underline: Container(alignment: Alignment.center, height: 0),
              items: minutesList.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [Text(e.value), const Text("mins")],
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    widget.notifyParent(selectedHour * 60 + value);
                    selectedMinute = value;
                  }
                });
              }),
        ),
      ],
    );
  }
}

class TimeOption extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeOption({
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
