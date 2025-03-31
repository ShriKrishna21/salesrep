import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:salesrep/modelClasses/createUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Createregionalhead extends StatefulWidget {
  const Createregionalhead({super.key});

  @override
  State<Createregionalhead> createState() => _CreateregionalheadState();
}

class _CreateregionalheadState extends State<Createregionalhead> {
  createUserModel? userdata;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController userid = TextEditingController();

  // Additional controllers for dynamic fields
  TextEditingController password = TextEditingController();
  TextEditingController regionCodeController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();

  String? Selecteduser;
  List<String> Usertype = ['region_head', 'unit_manager', 'agent'];
  Future<void> createuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userlog = await prefs.getString('apikey');
    try {
      const url = "http://10.100.13.138:8099/sales_rep_user_creation";
      final response = await http.post(Uri.parse(url),
          headers: {
          'Content-Type': 'application/json', // Required for JSON-RPC requests
          },
          body: jsonEncode({
            "params": {
              "token": userlog,
              "name": name.text,
              "unit_name": unit.text,
              "email": userid.text,
              "password": password.text,
              "role": Selecteduser,
            }
          }));
      if (response.statusCode == 200) {
        print("$response.stauscode");
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        userdata = createUserModel.fromJson(jsonResponse);
        if (userdata!.result?.code == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User created successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("user creation failed ")),
          );
        }
      }
    } catch (error) {
      print("error in creating user$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            text: "Create user  ",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 34,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  value: Selecteduser,
                  hint: Text("Select User Type"),
                  items: Usertype.map((String user) {
                    return DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      Selecteduser = newValue;
                    });
                  },
                ),
                SizedBox(height: 10),
                usercredentials(
                    controller: name,
                    hintText: "Name",
                    errorText: "please enter valid name"),
                usercredentials(
                    controller: unit,
                    hintText: "Unit name",
                    errorText: "please enter valid name"),
                usercredentials(
                    controller: userid,
                    hintText: "user id",
                    errorText: "please enter valid name"),
                usercredentials(
                    controller: password,
                    hintText: "password",
                    errorText: "please enter valid name"),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: ()async {
                
                      // if(_formKey.currentState?.validate() ?? false){
                       await createuser();
                    //  }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 28,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.blue,
                    child: Center(
                        child: Text(
                      "create User",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 56,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class usercredentials extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;

  const usercredentials({
    required this.controller,
    required this.hintText,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 4),
          )
        ],
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) ;
          {
            return errorText;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          filled: true,
          fillColor: Colors.blueGrey[200],
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
