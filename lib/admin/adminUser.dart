import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesrep/admin/admin.dart';
import 'package:salesrep/admin/adminprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class adminUser extends StatefulWidget {
  const adminUser({super.key});

  @override
  State<adminUser> createState() => _adminUserState();
}

class _adminUserState extends State<adminUser> {
  Future<void> circulationHeadLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = await prefs.getString('apikey');
    try {
      final token =
          apiKey;

      final uri = Uri.http(
        '10.100.13.138:8099',
        'api/users?',
        {
          'params.token': token,
        },
      );

      final respond = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("Response: ${respond.body}");
      if (respond.statusCode == 200) {
        final jsonResponse = jsonDecode(respond.body) as Map<String, dynamic>;

        //  if (logout!.result?.code == "200") {
        //   print("Logout successful");
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginscreen(),));

        //   }
        //       else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text("Log out failed")),
        //   );
        // }
      }
    } catch (error) {
      print("something went wrong : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => adminProfile(),
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2, color: Colors.white, style: BorderStyle.solid)),
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.height / 16,
              ),
            ),
          )
        ],
        title: RichText(
          text: TextSpan(
              text: "Name \n",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: "Circulation Head",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ]),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
              onPressed: () {
                circulationHeadLogout();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => admin(),
                //     ));
              },
              child: const Text(
                "Create User",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => admin(),
                  ));
            },
            child: const Text(
              "Display User",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
