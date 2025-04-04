import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salesrep/agent/coustmerform.dart';
import 'package:salesrep/unit_manager_dashboard.dart';

class CreateUnitManager extends StatefulWidget {
  const CreateUnitManager({super.key});

  @override
  State<CreateUnitManager> createState() => _CreateUnitManagerState();
}

class _CreateUnitManagerState extends State<CreateUnitManager> {
  String? selectedRouteMap;
  List<String> routeMaps = [
    'sr nagar -ameerpet',
    'punjagutta -soamjiguda',
    'Madhura nagar - yousafguda',
    'moosapet-bharath nagar'
  ];

  TextEditingController agentname = TextEditingController();
  TextEditingController agentuserid = TextEditingController();
  TextEditingController agentpasswod = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 12,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            text: "Create Agent  ",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 34,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AgentCredential(controller: agentname, hintText: "Agent name"),
            AgentCredential(controller: agentuserid, hintText: "Agent user id"),
            AgentCredential(
                controller: agentpasswod, hintText: "Agent Password"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: DropdownButtonFormField<String>(
                value: selectedRouteMap,
                decoration: InputDecoration(
                  hintText: 'Select Route Map',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                items: routeMaps.map((map) {
                  return DropdownMenuItem<String>(
                    value: map,
                    child: Text(map),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRouteMap = value;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                CollectionReference collref = FirebaseFirestore.instance.collection("employeeadetails");
                collref.add({'Agent name':agentname.text,
                'Agent userid':agentuserid.text,
                'Agent password':agentpasswod.text,
                'route map':selectedRouteMap
                }
                
                );
                ScaffoldMessenger(child: Text("data added sucessfully"));
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnitManagerDashboard(),));
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 30,
                width: MediaQuery.of(context).size.height / 7,
                child: Center(
                    child: Text(
                  "Create User",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height / 58,
                  ),
                )),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.yellow,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AgentCredential extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AgentCredential({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 4),
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          filled: true,
          fillColor: Colors.blueGrey[200],
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }
}
