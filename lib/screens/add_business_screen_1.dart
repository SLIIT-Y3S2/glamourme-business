import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/screens/add_business_screen_2.dart';
import 'package:glamourmebusiness/widgets/next_btn.dart';


class AddbusinessScreen1 extends StatefulWidget {
  const AddbusinessScreen1({Key? key}) : super(key: key);

  @override
  _AddbusinessScreen1State createState() => _AddbusinessScreen1State();
}

class _AddbusinessScreen1State extends State<AddbusinessScreen1> {
  String selectedService = '';

  void selectService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Business Screen')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            const Text(
              "What's your business Name?",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Inside scroll view
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Business name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'E.g., ABC Corporation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Website (optional)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'E.g., www.example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black54, width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServiceOption(
                      service: "Unisex",
                      isSelected: selectedService == "Unisex",
                      onTap: () {
                        selectService("Unisex");
                      },
                    ),
                    ServiceOption(
                      service: "Male",
                      isSelected: selectedService == "Male",
                      onTap: () {
                        selectService("Male");
                      },
                    ),
                    ServiceOption(
                      service: "Female",
                      isSelected: selectedService == "Female",
                      onTap: () {
                        selectService("Female");
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Selected Service: $selectedService',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(),
                NextButton(onPressed: () {
                // Navigate to the new screen when the button is pressed.
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => AddbusinessScreen2(), // Use the SecondScreen widget from the imported file.
                //   ),
                // );
              },)


                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceOption extends StatelessWidget {
  final String service;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceOption({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.green : Colors.white,
        child: SizedBox(
          width: 100,
          height: 80,
          child: Center(
            child: Text(
              service,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
