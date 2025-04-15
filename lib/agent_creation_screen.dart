import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AgentCreationScreen extends StatefulWidget {
  const AgentCreationScreen({super.key});

  @override
  State<AgentCreationScreen> createState() => _AgentCreationScreenState();
}

class _AgentCreationScreenState extends State<AgentCreationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController unitNameController = TextEditingController();
  TextEditingController agentAddressController = TextEditingController();

  File? imageFile;
  String? base64Image;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      String base64String = base64Encode(imageBytes);
      setState(() {
        imageFile = file;
        base64Image = base64String;
      });
      // print("Base64 String:$base64String");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Agent Creation Screen",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            NameTextFormField(
              hint: "NAME",
              controller: nameController,
            ),
            const SizedBox(
              height: 30,
            ),
            NameTextFormField(
              hint: "MOBILE NUMBER",
              controller: mobileNumberController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text("UPLOAD YOUR IMAGE")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        imageFile = null;
                        base64Image = null;
                        imageController.clear();
                      });
                    },
                    child: const Text("CLEAR IMAGE")),
              ],
            ),
            if (imageFile != null) ...[
              const SizedBox(height: 20),
              Image.file(
                imageFile!,
                height: 150,
              ),
            ],
            const SizedBox(
              height: 100,
            ),
            NameTextFormField(
              hint: "UNIT NAME",
              controller: unitNameController,
            ),
            const SizedBox(
              height: 30,
            ),
            NameTextFormField(
              hint: "AGENTADDRESS",
              maxl: 3,
              minl: 1,
              controller: agentAddressController,
            ),   const SizedBox(
              height: 30,
            ),
          ElevatedButton(onPressed: (){}, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}

class NameTextFormField extends StatelessWidget {
  final String hint;
  final int minl;
  final int maxl;
  final TextEditingController controller;
  const NameTextFormField({
    required this.hint,
    required this.controller,
    this.maxl = 3,
    this.minl = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        controller: controller,
        minLines: minl,
        maxLines: maxl,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
      ),
    );
  }
}
