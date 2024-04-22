import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 11, 114, 118)),
        useMaterial3: true,
      ),
      title: 'TB XRay Classifier',
      home: XRayPage(),
    );
  }
}

class XRayPage extends StatefulWidget {
  @override
  _ImageClassifierAppState createState() => _ImageClassifierAppState();
}

class _ImageClassifierAppState extends State<XRayPage> {
  File? _image;
  String? _prediction;

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _predictXRAY() async {
    if (_image == null) {
      // Handle case when no image is selected
      return;
    }

    final uri = Uri.parse('https://6785-110-225-199-243/predict');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      setState(() {
        _prediction = responseBody;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 32, 211, 217),
        backgroundColor: Color.fromARGB(255, 179, 240, 249),
        title: Text(
          'TB XRay Classifier Page',
          style: TextStyle(
            color: Color.fromARGB(
                255, 8, 80, 82), // Change the color to your desired text color
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/background.png', // Change this to your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            // Center everything horizontally and vertically
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  if (_image != null) ...[
                    Image.file(
                      _image!,
                      width: 200,
                      height: 200,
                    ),
                    Text(_prediction ?? ''),
                  ],
                  ElevatedButton(
                    onPressed: _uploadImage,
                    style: ButtonStyle(
                      // Increase the minimum size of the button
                      minimumSize: MaterialStateProperty.all(Size(160, 60)),
                      // You can customize other styles like background color, text color, etc.
                    ),
                    child: Text(
                      'Upload X-Ray',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictXRAY,
                    style: ButtonStyle(
                      // Increase the minimum size of the button
                      minimumSize: MaterialStateProperty.all(Size(150, 60)),
                      // You can customize other styles like background color, text color, etc.
                    ),
                    child: Text(
                      'Prediction for X-Ray',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ], // children
      ), // stack
    );
  }
}
