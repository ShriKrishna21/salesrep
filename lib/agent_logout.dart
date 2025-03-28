import 'dart:convert';
import 'package:salesrep/loginscreen.dart';

import 'agent_logout_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AgentLogout extends StatefulWidget {
  const AgentLogout({super.key});

  @override
  State<AgentLogout> createState() => _AgentLogoutState();
}

class _AgentLogoutState extends State<AgentLogout> {
  String unitname = "";
  String jobrole = '';
  String userid = "";
  agentlogout? logoutt;
  Future<void> agentLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = await prefs.getString('apikey');
    print(" nnnnnnnnnnnnnnnnnnnnnnnn${apiKey}");
    try {
      const url = 'http://10.100.13.138:8099/token_validation';
      final respond = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Required for JSON-RPC requests
        },
        body: jsonEncode({
          "params": {
            "token": apiKey.toString(),
          }
        }),
      );
      if (respond.statusCode == 200) {
        final jsonResponse = jsonDecode(respond.body) as Map<String, dynamic>;
        setState(() {
          logoutt = agentlogout.fromJson(jsonResponse);
        });

        print(" hashhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${respond.statusCode}");
      }
      if(logoutt!.result!.code == "200"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginscreen(),));

        print("sucessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
      }
      else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Log out failed")),
          );
        }
    } catch (error) {
      print("something went wrong : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF7FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF4A90E2),
        title: Text('My Profile'),
        
      ),
      body: Column(
        children: [
       const   SizedBox(height: 20),
         const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black12,
                child: Icon(Icons.person, size: 60, color: Colors.black54),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 14,
                  child: Icon(Icons.edit, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileItem("Name", "Prashant"),
                profileItem("User Name", "Prashant01@eenadu"),
                profileItem("Job role", "Eenadu Agent"),
                profileItem("unit name", "8827530290"),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  agentLogout();
                  
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
    );
  }

  Widget profileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text("$title", style: TextStyle(fontSize: 16))),
          Text(":", style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
