import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'xray.dart';
import 'sputum.dart';
import 'voice.dart';

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
      title: 'Image Classifier',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 240, 249),
        title: Text(
          'TB Detector Page',
          style: TextStyle(
            color: Color.fromARGB(255, 8, 80, 82),
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
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => XRayPage()),
                      );
                      
                    },
                    child: Text('TB XRay Prediction'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SputumPage()),
                      );
                    },
                    child: Text('TB Sputum Image Prediction'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoicePage()),
                      );
                    },
                    child: Text('TB Voice Prediction'),
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
