import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/location/location_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/screens/business_create_screen4.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessCreationLocationDetails extends StatefulWidget {
  final BasicSalonDetails basicSalonDetails;
  final List<CategoryModel> selectedCategories;
  const BusinessCreationLocationDetails({
    super.key,
    required this.basicSalonDetails,
    required this.selectedCategories,
  });

  @override
  State<BusinessCreationLocationDetails> createState() =>
      _BusinessCreationLocationDetailsState();
}

class _BusinessCreationLocationDetailsState
    extends State<BusinessCreationLocationDetails> {
  late GoogleMapController mapController;
  final Map<String, LatLng> latLngList = {};

  final _locationTextController = TextEditingController();
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(const GetLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // title: const Text('Create Business'),
              ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Where is your business located at?',
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
                _buildInputField('Enter City Name', 'City'),
                const SizedBox(height: 24),
                state is LocationLoaded
                    ? Expanded(
                        child: Stack(
                          children: [
                            GoogleMap(
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              zoomControlsEnabled: false,
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer()),
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  state.location.latitude,
                                  state.location.longitude,
                                ),
                                zoom: 15,
                              ),
                              onCameraMove: (CameraPosition? position) {
                                if (selectedLocation != position!.target) {
                                  setState(() {
                                    selectedLocation = position.target;
                                  });
                                }
                              },
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : state is GettingLocation
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Center(
                            child: Text('Something went wrong'),
                          ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: _nextButton(context),
          ),
        );
      },
    );
  }

  Widget _buildInputField(
    String labelText,
    String placeholder,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 2, left: 9),
          child: Text(
            labelText,
            style: const TextStyle(
              color: Color(0xFF1C1C28),
              fontSize: 14,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFC7C8D8)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: _locationTextController,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFF8E90A5),
                fontSize: 16,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_locationTextController.text.length < 3 ||
              selectedLocation == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please enter a valid address'),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessCreationOpeningHours(
                basicSalonDetails: widget.basicSalonDetails,
                selectedCategories: widget.selectedCategories,
                location: _locationTextController.text,
                lanLat: selectedLocation!,
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
