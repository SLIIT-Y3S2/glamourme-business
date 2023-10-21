import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/screens/my_businesss_add_new_service_screen.dart';
import 'package:glamourmebusiness/widgets/edit_service_card.dart';
import 'package:glamourmebusiness/widgets/next_btn.dart';

class MyBusinessServices extends StatefulWidget {
  const MyBusinessServices({super.key});

  @override
  State<MyBusinessServices> createState() => _MyBusinessServicesState();
}

class _MyBusinessServicesState extends State<MyBusinessServices> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SalonBloc>(context).add(GetSalonEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalonBloc, SalonState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Your Services')),
            body: state is SalonLoaded
                ? ListView(
                    children: [
                      ...state.salon.services.map((service) {
                        return EditServiceCard(
                          salonId: state.salon.salonId!,
                          service: service,
                        );
                      }).toList()
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
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
      },
    );
  }
}
