import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salesrep/firebase_options.dart';
import 'package:salesrep/homescreen.dart';
import 'package:salesrep/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options:DefaultFirebaseOptions.currentPlatform);


  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Loginscreen(),
      //  isLoggedIn ? const AgentDashBoardScreen() :
    );
  }
}
