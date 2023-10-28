import 'dart:io';
import 'dart:developer' as developer;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadToFirebase extends StatefulWidget {
  final void Function(String imageURL) notifyParent;
  const UploadToFirebase({super.key, required this.notifyParent});

  @override
  State<UploadToFirebase> createState() => _UploadToFirebaseState();
}

class _UploadToFirebaseState extends State<UploadToFirebase> {
  File? _photo;
  UploadTask? task;
  String? downloadURL;
  final ImagePicker _picker = ImagePicker();

  Future selectFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _uploadFile();
      } else {
        developer.log('No image selected.', name: 'UploadToFirebase');
      }
    });
  }

  Future _uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName ${DateTime.now()}';

    final ref = FirebaseStorage.instance.ref(destination);
    setState(() {
      task = ref.putFile(_photo!);
    });

    final snapshot = await task!.whenComplete(() => null);
    final urlDownload = await snapshot.ref.getDownloadURL();
    developer.log('Download-Link: $urlDownload', name: 'UploadToFirebase');
    setState(() {
      if (urlDownload != null) {
        downloadURL = urlDownload;
        widget.notifyParent(downloadURL!);
      }
    });
    setState(() {
      task = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // backgroundColor: green1,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(8),
              // ),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: green1)),
              // textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              selectFile();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file),
                Text('Upload Image'),
              ],
            ),
          ),
        ),
        if (downloadURL != null)
          SizedBox(
            width: double.infinity,
            child: Container(
              child: Image.network(
                downloadURL!,
                // width: double.infinity,
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        if (task != null)
          StreamBuilder<TaskSnapshot>(
            stream: task!.snapshotEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!;
                final progress = snap.bytesTransferred / snap.totalBytes;
                final percentage = (progress * 100).toStringAsFixed(2);
                return Text('$percentage %');
              } else {
                return const Text('0 %');
              }
            },
          ),
      ],
    );
  }
}
