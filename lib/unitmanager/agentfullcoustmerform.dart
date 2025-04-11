import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agentfullcoustmerform extends StatefulWidget {
  const Agentfullcoustmerform({super.key});

  @override
  State<Agentfullcoustmerform> createState() => _AgentfullcoustmerformState();
}

class _AgentfullcoustmerformState extends State<Agentfullcoustmerform> {
    bool isLoading = false;

  Future<void>futurecoustmerform()async{
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('apikey');
    final int? id = prefs.getInt('id');

    const String url = 'http://10.100.13.138:8099/api/customer_forms_info_id';
    if(apiKey==null){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing API Key")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    try{
       final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "params": {
                "token": apiKey,
              }
            }),
          )
          .timeout(const Duration(seconds: 20));
          if(response.statusCode==200){
            
          }
    }
    catch(error){

    }


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    );
  }
}