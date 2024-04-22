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
      title: 'TB Image Classifier',
      home: SputumPage(),
    );
  }
}

class SputumPage extends StatefulWidget {
  @override
  _SputumPageState createState() => _SputumPageState();
}

class _SputumPageState extends State<SputumPage> {
  File? _image;
  String? _prediction;

  Future<void> _uploadTBImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _predictImage() async {
    if (_image == null) {
      // Handle case when no image is selected
      return;
    }

    final response = await http.post(
      Uri.parse(' http://127.0.0.1:4040/detect_tb'),
      body: {'image': _image!.path},
    );

    if (response.statusCode == 200) {
      setState(() {
        _prediction = response.body;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 240, 249),
        title: Text(
          'TB Image Detector Page',
          style: TextStyle(
            color: Color.fromARGB(255, 8, 80, 82),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    onPressed: _uploadTBImage,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 60)),
                    ),
                    child: Text(
                      'Upload TB Image',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictImage,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(150, 60)),
                    ),
                    child: Text(
                      'Prediction for TB Image',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
