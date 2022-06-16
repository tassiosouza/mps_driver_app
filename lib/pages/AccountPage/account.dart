import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'dart:developer';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Image Picker Demo',
      home: MyHomePage(title: 'Image Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _imageFile;
  late TwilioFlutter twilioFlutter;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: 'ACfcf134f0de9f85c19790e91e29cb6d63',
        authToken: '4335317aa987c70f6263b960ef453d2f',
        twilioNumber: '4122741864');
    super.initState();
  }

  Future<void> sendSms(XFile? photo) async {
    String url = await createAndUploadFile(photo!);
    twilioFlutter.sendSMS(
        toNumber: '+16197634382',
        messageBody: 'test',
        messageMediaUrl: url);
  }

  void _setImageFileFromFile(XFile? value) {
    _imageFile = value;
  }

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  Future<String> createAndUploadFile(XFile pickedFile) async {
    // Upload image with the current time as the key
    final key = DateTime.now().toString();
    final file = File(pickedFile.path);
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          onProgress: (progress) {
            print("Fraction completed: " +
                progress.getFractionCompleted().toString());
          });
      print('Successfully uploaded image: ${result.key}');
      GetUrlResult urlResult = await Amplify.Storage.getUrl(key: result.key);
      return urlResult.url;
    } on StorageException catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 800,
        imageQuality: 100,
      );
      setState(() {
        _setImageFileFromFile(pickedFile);
      });
      sendSms(pickedFile);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: Image.file(File(_imageFile!.path)),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _previewImages(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image2',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
