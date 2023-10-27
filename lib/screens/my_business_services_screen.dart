import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/screens/my_businesss_add_new_service_screen.dart';
import 'package:glamourmebusiness/widgets/edit_service_card.dart';
import 'package:glamourmebusiness/widgets/next_btn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return BlocListener<SalonBloc, SalonState>(
      listener: (context, state) {
        if (state is ServiceCreatedState) {
          BlocProvider.of<SalonBloc>(context).add(const GetSalonEvent());
        }
      },
      child: BlocBuilder<SalonBloc, SalonState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.yourServices)),
              body: state is SalonLoaded
                  ? state.salon.services.isNotEmpty
                      ? ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            ...state.salon.services.map((service) {
                              return EditServiceCard(
                                salonId: state.salon.salonId!,
                                service: service,
                              );
                            }).toList()
                          ],
                        )
                      : const Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 48,
                              color: Color.fromARGB(255, 92, 92, 92),
                            ),
                            Text("No Services Added Yet"),
                          ],
                        ))
                  : const Center(child: CircularProgressIndicator()),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                    buttonText: AppLocalizations.of(context)!.addnewserviceBtn,
                  ),
                ),
              ));
        },
      ),
    );
  }
}
