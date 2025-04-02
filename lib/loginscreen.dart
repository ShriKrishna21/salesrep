import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesrep/agent_dash_board_screen.dart';
import 'package:salesrep/circulationHead/circulationHeadUser.dart';
import 'package:salesrep/homescreen.dart';
import 'package:salesrep/regionalHead/regionalheaduser.dart';
import 'package:salesrep/unit_manager_dashboard.dart';
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
  final response = 0;
  String? api="http://10.100.13.138:8099";

  loginmodel? _loginData; // Variable to store fetched login data

  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  Future<void> fetchAlbum() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final url = '$api/web/session/authenticate';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Required for JSON-RPC requests
        },
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
        print(response.statusCode);
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          _loginData = loginmodel.fromJson(jsonResponse);
    
          print(" login data ==> ${_loginData!.toJson().toString()}");
        });
        print(" result code => ${_loginData!.result!.code}");

        //circulation head dash board
        if (_loginData!.result!.code == "200" &&
            _loginData!.result!.name == "admin") {
          print("Redirect to circulation head dashboard");
          await prefs.setString(
              'apikey', _loginData!.result!.apiKey.toString());
              await prefs.setString('Name', _loginData!.result!.name.toString());

          await prefs.setString('unit', _loginData!.result!.unit.toString());
          await prefs.setString(
              'role', _loginData!.result!.roleLeGr.toString());
          await prefs.setString('id', _loginData!.result!.userId.toString());
          print("unitname ${_loginData!.result!.unit.toString()}");
          print("apikey${_loginData!.result!.apiKey.toString()}");

          final String? action = prefs.getString('apikey');
          print(" API KEY => $action");
          print("data$_loginData");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Circulationheaduser()),
          );
        }  if (_loginData!.result!.code == "200" &&
            _loginData!.result!.roleLeGr == "") {
              print("Redirect to Regional head dashboard");
                Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Regionalheaduser()),
          );

            }
      } else {
        throw Exception(
            "Failed to fetch the API: Status code ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    } finally {
      // print("API data fetch");
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
              height: MediaQuery.of(context).size.height * 0.6,
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
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 50),
                      child: TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                   SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height / 50),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: const Icon(Icons.visibility),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        fixedSize: Size(
                          MediaQuery.of(context).size.height / 3.3,
                          MediaQuery.of(context).size.height / 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        //   fetchAlbum();
                        if (_formKey.currentState?.validate() ?? false) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);
                          await fetchAlbum();
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UnitManagerDashboard(),
                              ));
                        },
                        child: Text("unit manager"))
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
