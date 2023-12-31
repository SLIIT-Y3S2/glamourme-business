import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/data/service_categories.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/service_model.dart';
import 'package:glamourmebusiness/widgets/gender_selection_option_widget.dart';
import 'package:glamourmebusiness/widgets/select_time.dart';
import 'package:glamourmebusiness/widgets/upload_image_to_firebase_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBusinessAddNewService extends StatefulWidget {
  const MyBusinessAddNewService({super.key});

  @override
  MyBusinessAddNewServiceState createState() => MyBusinessAddNewServiceState();
}

class MyBusinessAddNewServiceState extends State<MyBusinessAddNewService> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceDescriptionController =
      TextEditingController();
  String _serviceGender = 'unisex';
  int _serviceTotalMins = 0;
  String? imageDownloadURL;
  final TextEditingController _servicePriceController = TextEditingController();

  void selectService(String service) {
    setState(() {
      _serviceGender = service;
    });
  }

  void refreshUrl(imageURL) {
    setState(() {
      imageDownloadURL = imageURL;
    });
  }

  void refreshTotalMins(int totalMins) {
    setState(() {
      _serviceTotalMins = totalMins;
    });
  }

  String selectedCategory = categoryData[0].name;

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<SalonBloc>(context).add(GetSalonEvent());
    return BlocListener<SalonBloc, SalonState>(
      listener: (context, state) {
        if (state is ServiceCreatedState) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SalonBloc, SalonState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.addnewserviceTopic,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    _textField(
                      labelText: 'Service Name',
                      hintText: 'ex: Haircut',
                      controller: _serviceNameController,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ------------------------------------------ DROP down ------------->>>>>>>>>>>>>

                    const Text(
                      'Select Category',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.black54,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCategory,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          }
                        },
                        items: categoryData.map<DropdownMenuItem<String>>(
                            (CategoryModel value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.name),
                            ),
                          );
                        }).toList(),
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // -------------------------- description ------->>>>

                    _textField(
                        controller: _serviceDescriptionController,
                        hintText: 'Describe your service...',
                        labelText: 'Service Description',
                        isDescription: true),
                    // -------------------------- service available for ------->>>>
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Service Available for',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    _serveForGenderRadioButton(),
                    // --------------------- select time  ---------------->>>>>

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Select Duration',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    SelectTime(
                      notifyParent: refreshTotalMins,
                    ),

                    // --------------------- select price  ---------------->>>>>
                    const SizedBox(
                      height: 20,
                    ),
                    _textField(
                      controller: _servicePriceController,
                      hintText: '2000',
                      labelText: 'Service Price',
                      isNumber: true,
                    ),

                    // --------------------- upload image to firebase  ---------------->>>>>
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Upload Image',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    UploadToFirebase(
                      notifyParent: refreshUrl,
                    ),
                  ],
                ),
              ),
            ),

            // ------------------------------------------- bottom navigation -------------->>>>>>>
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: black3, width: 1),
                        // Add a green color border
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Add a border radius
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // -------------------- this is next button ---------------------------->>>>>>>>>>>>>>>>>>
                  if (state is SalonLoading)
                    const Center(child: CircularProgressIndicator()),

                  if (state is SalonLoaded && state.salon.salonId != null)
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (imageDownloadURL == null ||
                              _serviceTotalMins == 0 ||
                              _serviceNameController.text.isEmpty ||
                              _serviceDescriptionController.text.isEmpty ||
                              _servicePriceController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all the fields'),
                              ),
                            );
                          } else {
                            BlocProvider.of<SalonBloc>(context)
                                .add(CreateServiceEvent(
                              salonId: state.salon.salonId!,
                              service: ServiceModel.init(
                                serviceGender: _serviceGender,
                                imageUrl: imageDownloadURL!,
                                name: _serviceNameController.text,
                                description: _serviceDescriptionController.text,
                                price:
                                    double.parse(_servicePriceController.text),
                                duration: _serviceTotalMins.toString(),
                              ),
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.green, width: 1),
                          backgroundColor: green1, // Add a green color border
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Add a border radius
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _textField({
    required TextEditingController? controller,
    required String hintText,
    required String labelText,
    bool isNumber = false,
    bool isDescription = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),
          TextField(
            // keyboardType: TextInputType.multiline,
            maxLines: isDescription ? 5 : 1,
            controller: controller,
            keyboardType: isNumber
                ? TextInputType.number
                : isDescription
                    ? TextInputType.multiline
                    : TextInputType.text,
            inputFormatters: <TextInputFormatter>[
              // if (isNumber) FilteringTextInputFormatter.digitsOnly,
              if (isNumber)
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: isNumber
                  ? const SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          'Rs.',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : null,
              border: const OutlineInputBorder(
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
        ],
      ),
    );
  }

  Widget _serveForGenderRadioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ServiceOption(
          service: "Unisex",
          isSelected: _serviceGender == "unisex",
          onTap: () {
            selectService("unisex");
          },
        ),
        ServiceOption(
          service: "Gents",
          isSelected: _serviceGender == "gents",
          onTap: () {
            selectService("gents");
          },
        ),
        ServiceOption(
          service: "Ladies",
          isSelected: _serviceGender == "ladies",
          onTap: () {
            selectService("ladies");
          },
        ),
      ],
    );
  }
}
