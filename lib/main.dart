import 'package:flutter/material.dart';
import 'package:salesrep/loginscreen.dart';
import 'package:salesrep/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp(
//   options:DefaultFirebaseOptions.currentPlatform);



  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
      //  isLoggedIn ? const AgentDashBoardScreen() :
    );
  }
}
