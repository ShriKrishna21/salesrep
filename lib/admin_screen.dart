import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  File? _selectedImage;
  String? _base64Image;
Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile =
      await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64String = base64Encode(imageBytes);

    setState(() {
      _selectedImage = imageFile;
      _base64Image = base64String;
    });

    debugPrint(
        "Base64 Image: ${_base64Image?.substring(0, 50)}..."); // Printing only a part for debugging
  }
}


  Future<void> _sendData() async {
    const String url = "https://10.100.13.138:8099/sales_rep_user_creation";
    const String staticToken =
        "8a0d4c01e95e4b4332bd0e0e4cbe9a7636b7fdcc906a8444bf62ca919302c28b";

    User? user = FirebaseAuth.instance.currentUser;
    String? idToken = await user?.getIdToken();

    if (idToken == null) {
      debugPrint("Error: User not authenticated");
      return;
    }

    Map<String, dynamic> data = {
      "params": {
        "token": idToken, // Ensure the token is dynamically fetched
        "name": "Captain",
        "email": "captain@gmail.com",
        "password": "abc123",
        "role": "agent",
        "aadhar_number": "123456",
        "pan_number": "hello123",
        "state": "AP",
        "status": "active",
        "phone": "2580",
        "unit_name": "Guntur",
        "aadhar_base64": _base64Image ?? "",
        "pan_base64": "",
      }
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              " $staticToken", 
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint("Data sent successfully: ${response.body}");
      } else {
        debugPrint(
            "Failed to send data: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _saveDataToFirestore() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection("users");

    try {
      await usersCollection.add({
        "name": "",
        "email": "",
        "role": "",
        "phone": "",
        "state": "",
        "status": "",
      });
      debugPrint("User data saved to Firestore.");
    } catch (e) {
      debugPrint("Error saving data to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200)
                : const Text("No Image Selected"),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _pickImage, child: const Text("Pick Image")),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _sendData, child: const Text("Send Data")),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _saveDataToFirestore,
                child: const Text("Save to Firestore")),
          ],
        ),
      ),
    );
  }
}
