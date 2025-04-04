import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesrep/UserLogoutModel.dart';
import 'package:http/http.dart' as http;
import 'package:salesrep/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class adminProfile extends StatefulWidget {
  const adminProfile({super.key});

  @override
  State<adminProfile> createState() => _adminProfileState();
}

class _adminProfileState extends State<adminProfile> {
  String? Name;
  String? username;
  String? jobrole;
  String? unitname;
  userlogout? logout;

  Future<void> circulationHeadLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = await prefs.getString('apikey');
    try {
      const url = 'http://10.100.13.138:8099/token_validation';
      final respond = await http.post(Uri.parse(url),
          headers: {
            'Content-Type':
                'application/json', // Required for JSON-RPC requests
          },
          body: jsonEncode({
            "params": {
              "token": apiKey.toString(),
            }
          }));
          if (respond.statusCode == 200) {
        final jsonResponse = jsonDecode(respond.body) as Map<String, dynamic>;
       logout=userlogout.fromJson(jsonResponse);
       if (logout!.result?.code == "200") {
        print("Logout successful");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginscreen(),));

        }
              else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Log out failed")),
          );
        }

       
      }
    } catch (error) {
      print("something went wrong : $error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveddata();
  }

  Future<void> saveddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final String? name = prefs.getString('Name');
      final String? id = prefs.getString('id');
      final String? role = prefs.getString('role');
      final String? unit = prefs.getString('unit');

      Name = name;
      username = id;
      jobrole = role;
      unitname = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFDF7FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF4A90E2),
          title: Text('My Profile'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF4F7F2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            children: [
             
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      circulationHeadLogout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
