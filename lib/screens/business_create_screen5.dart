import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamourmebusiness/blocs/authentication/authentication_bloc.dart';
import 'package:glamourmebusiness/blocs/salon/salon_bloc.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/widgets/upload_image_to_firebase_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessCreationUploadImage extends StatefulWidget {
  final BasicSalonDetails basicSalonDetails;
  final List<CategoryModel> selectedCategories;
  final String location;
  final LatLng lanLat;
  final List<OpeningHoursDataModel> openingHours;
  const BusinessCreationUploadImage({
    super.key,
    required this.basicSalonDetails,
    required this.selectedCategories,
    required this.location,
    required this.openingHours,
    required this.lanLat,
  });

  @override
  State<BusinessCreationUploadImage> createState() =>
      _BusinessCreationUploadImageState();
}

class _BusinessCreationUploadImageState
    extends State<BusinessCreationUploadImage> {
  String? _salonOwnerId;
  String? _imageDownloadURL;

  void refreshUrl(imageURL) {
    setState(() {
      _imageDownloadURL = imageURL;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context)
        .add(const GetCurrentUserEvent());
  }

  void _onSubmit() {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;

    if (authState is CurrentUserState) {
      if (authState.user == null) {
        developer.log('user is null', name: 'user');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please login to continue'),
          ),
        );
        return;
      } else {
        _salonOwnerId = authState.user!.userId;
      }
    }
    if (_imageDownloadURL == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image'),
        ),
      );
      return;
    }

    BlocProvider.of<SalonBloc>(context).add(
      CreateSalonEvent(
        salon: SalonModel.init(
          salonName: widget.basicSalonDetails.salonName,
          website: widget.basicSalonDetails.website,
          salonType: widget.basicSalonDetails.salonType,
          categories: widget.selectedCategories,
          location: widget.location,
          openingHours: widget.openingHours,
          salonOwnerId: _salonOwnerId!,
          contactNumber: '',
          description: '',
          latitude: widget.lanLat.latitude,
          longitude: widget.lanLat.longitude,
          imageUrl: _imageDownloadURL!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalonBloc, SalonState>(
      listener: (context, state) {
        if (state is SalonCreatedState) {
          // globalNavigatorKey.currentState!.pushReplacementNamed('/main');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Business Created!'),
            ),
          );
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            // title: const Text('Create Business'),
            ),
        body: Container(
          padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload an image of your business',
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
              UploadToFirebase(notifyParent: refreshUrl),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: _nextButton(context),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          _onSubmit();
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

// 