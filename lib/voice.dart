import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

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
      title: 'TB Voice Classifier',
      home: VoicePage(),
    );
  }
}

class VoicePage extends StatefulWidget {
  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  File? _voiceFile;
  String? _prediction;

  Future<void> _uploadVoice() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowCompression: true,
    );

    if (result != null) {
      setState(() {
        _voiceFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _predictVoice() async {
    if (_voiceFile == null) {
      // Handle case when no voice file is selected
      return;
    }

    final uri = Uri.parse('https://52.66.100.127/predict');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('voice', _voiceFile!.path));

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
        backgroundColor: Color.fromARGB(255, 179, 240, 249),
        title: Text(
          'TB Voice Classifier Page',
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
                  if (_voiceFile != null) ...[
                    Text(
                      'Selected Voice: ${_voiceFile!.path}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(_prediction ?? ''),
                  ],
                  ElevatedButton(
                    onPressed: _uploadVoice,
                    style: ButtonStyle(
                      // Increase the minimum size of the button
                      minimumSize: MaterialStateProperty.all(Size(160, 60)),
                      // You can customize other styles like background color, text color, etc.
                    ),
                    child: Text(
                      'Upload Voice',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictVoice,
                    style: ButtonStyle(
                      // Increase the minimum size of the button
                      minimumSize: MaterialStateProperty.all(Size(150, 60)),
                      // You can customize other styles like background color, text color, etc.
                    ),
                    child: Text(
                      'Predict Voice',
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
