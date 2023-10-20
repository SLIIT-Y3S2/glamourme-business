import 'package:flutter/material.dart';
import 'package:glamourmebusiness/screens/my_businesss_add_new_service_screen.dart';
import 'package:glamourmebusiness/widgets/edit_service_card.dart';
import 'package:glamourmebusiness/widgets/next_btn.dart';

class MyBusinessServices extends StatelessWidget {
  const MyBusinessServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add Business Screen')),
        body: EditServiceCard(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            child: NextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      // Replace `YourNextScreen` with the actual screen you want to navigate to
                      return MyBusinessAddNewService();
                    },
                  ),
                );
              },
              buttonText: "Add new service",
            ),
          ),
        ));
  }
}
