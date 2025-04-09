import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesrep/agent/agentDashBoard.dart';
import 'package:salesrep/admin/adminUser.dart';
import 'package:salesrep/constant.dart';
import 'package:salesrep/unitmanager/unitManagerDashboard.dart';
import 'package:salesrep/utils/colors.dart';
import 'package:salesrep/utils/login_model..dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  loginmodel? _loginData;

  Future<void> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = '${apiconstant.api}/web/session/authenticate';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'jsonrpc': "2.0",
          'method': "call",
          'params': {
            "login": usernameController.text,
            "password": passwordController.text,
          }
        }),
      );

    
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        _loginData = loginmodel.fromJson(jsonResponse);

        if (_loginData!.result!.code == "200") {
          await prefs.setString('apikey', _loginData!.result!.apiKey ?? '');
          await prefs.setString('name', _loginData!.result!.name ?? '');
          await prefs.setString('unit', _loginData!.result!.unit ?? '');
          await prefs.setString('role', _loginData!.result!.role ?? '');
          await prefs.setInt('id', _loginData!.result!.userId ?? 0);
          await prefs.setString('agentlogin', usernameController.text);

          switch (_loginData!.result!.role) {
            case "admin":
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const adminUser()));
              break;
            case "agent":
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => AgentDashBoardScreen()));
              break;
            case "unit_manager":
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => UnitManagerDashboard()));
              break;
        
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Unknown user role")),
              );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login failed: ${_loginData!.result!.code ?? 'Invalid credentials'}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/loginbackground.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                          value!.isEmpty ? "Username cannot be empty" : null,
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) =>
                          value!.isEmpty ? "Password cannot be empty" : null,
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: const Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        fixedSize: const Size(250, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await loginUser();
                        }
                      },
                      child: const Text("LOGIN", style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}