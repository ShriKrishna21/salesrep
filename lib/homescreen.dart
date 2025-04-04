import 'package:flutter/material.dart';
import 'package:salesrep/agent/coustmerform.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Coustmer(),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            height: MediaQuery.of(context).size.height / 18,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
                child: Text(
              "+coustmer Form",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
        ),
      ),
    );
  }
}
