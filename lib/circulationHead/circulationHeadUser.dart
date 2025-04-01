import 'package:flutter/material.dart';
import 'package:salesrep/circulationHead/circulationHeadProfile.dart';
import 'package:salesrep/circulationHead/createRegionalHead.dart';

class Circulationheaduser extends StatefulWidget {
  const Circulationheaduser({super.key});

  @override
  State<Circulationheaduser> createState() => _CirculationheaduserState();
}

class _CirculationheaduserState extends State<Circulationheaduser> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Circulationheadprofile(),));
             
            },
            child: Container(
              width: MediaQuery.of(context).size.height/10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white,style: BorderStyle.solid)
              ),
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
                    children:<TextSpan>[
                      
                  TextSpan(
              text: "Circulation Head",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold,color: Colors.black),)
                      
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
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => Createregionalhead(),));
              },
              child: const Text(
                "Create User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}