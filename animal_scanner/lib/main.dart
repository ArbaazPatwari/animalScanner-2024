import 'dart:io';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Animal Scanner Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<Map<String, String>> metadataList = [];


class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveMetadata() {
    final metadata = {
      'Length': _lengthController.text,
      'Weight': _weightController.text,
      'Location': _locationController.text,
      'Time': _timeController.text,
    };

    setState(() {
      metadataList.add(metadata);
    });

    // Print the current metadata list
    if (kDebugMode) {
      print(metadataList);
    }

    // Clear the input fields
    _lengthController.clear();
    _weightController.clear();
    _locationController.clear();
    _timeController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Input fields for metadata
            TextField(
              controller: _lengthController,
              decoration: InputDecoration(labelText: 'Length (cm)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveMetadata,
              child: const Text('Save Metadata'),
            ),
            // Placeholder for displaying saved metadata
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // Placeholder for future functionality
        tooltip: 'Placeholder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
