import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/widgets/select_time.dart';

class Addbusinessscreen2 extends StatefulWidget {
  const Addbusinessscreen2({super.key});

  @override
  _AddbusinessScreen2State createState() => _AddbusinessScreen2State();
}

class _AddbusinessScreen2State extends State<Addbusinessscreen2> {
  String selectedService = '';

  void selectService(String service) {
    setState(() {
      selectedService = service;
    });
  }

  String selectedCompany = 'facial & Skin Care';

  List<String> companyList = [
    'facial & Skin Care',
    'Nail',
    '123 Industries',
    'Example Company',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: <Widget>[
              const Text(
                "Add New Service",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -------------------- business name ---------------------->>>>>>>>>>>>>>>

                  const Text(
                    'Service Name',
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

                  // ------------------------------------------ DROP down ------------->>>>>>>>>>>>>

                  const Text(
                    'Select Category',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1.0,
                      ),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedCompany,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCompany = newValue;
                          });
                        }
                      },
                      items: companyList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                      underline: Container(),
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // -------------------------- description ------->>>>

                  const Text(
                    'Service Description',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),

                  Container(
                    width: double.infinity, // Max width
                    height: 100.0, // Desired height
                    child: const TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
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
                  ),

                  // -------------------------- service available for ------->>>>
                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Service Available for',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
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
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   'Selected Service: $selectedService',
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.green,
                  //   ),
                  // ),

                  // --------------------- select time  ---------------->>>>>

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    'Select time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SelectTime();
                    },
                  )
                ],
              ),
            ],
          ),
        ),

        // ------------------------------------------- bottom navigation -------------->>>>>>>
        bottomNavigationBar: // After
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 120,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: black3, width: 1),
                    // Add a green color border
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Add a border radius
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  onPressed: null,
                ),
              ),

              // -------------------- this is next button ---------------------------->>>>>>>>>>>>>>>>>>

              Container(
                width: 120,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.green, width: 1),
                    backgroundColor: green1, // Add a green color border
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Add a border radius
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  onPressed: null,
                ),
              )
            ],
          ),
        ));
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
