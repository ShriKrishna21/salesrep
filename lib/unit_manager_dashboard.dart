import 'package:flutter/material.dart';
import 'package:salesrep/create_unit_manager.dart';

class UnitManagerDashboard extends StatefulWidget {
  const  UnitManagerDashboard({super.key});

  @override
  State<UnitManagerDashboard> createState() => _UnitManagerDashboardState();
}

class _UnitManagerDashboardState extends State<UnitManagerDashboard> {
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AgentLogout(),));
            },
            child: Container(
              width: 50,
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
              text: "Unit manager - ",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 30,
                  fontWeight: FontWeight.bold),
                    children:<TextSpan>[
                      TextSpan(
              text: "Puma\n",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                  fontWeight: FontWeight.bold,color: Colors.black),),
                  TextSpan(
              text: "karimnagar",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 44,
                  fontWeight: FontWeight.bold,color: Colors.white),)
                      
                    ]),
                  
                  
        ),
      
        automaticallyImplyLeading: false,

      ),
       body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildCard(
                  title: "Number of resources",
                  gradientColors: [Colors.white, Colors.redAccent],
                  rows: const [
                    _InfoRow(label: "Agents", value: "0"),
                  ],
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Subscription Details",
                  gradientColors: [Colors.white, Colors.green],
                  rows: const [
                    _InfoRow(label: "Houses Count", value: "1000", bold: true),
                    _InfoRow(label: "Houses Visited", value: "0"),
                    _InfoRow(label: "Eenadu subscription", value: "0"),
                    _InfoRow(label: "Willing to change", value: "0"),
                    _InfoRow(label: "Not Interested", value: "0"),
                  ],
                ),
                const SizedBox(height: 20),
                _buildCard(
                  title: "Route Map",
                  gradientColors: [Colors.white, Colors.redAccent],
                  rows: const [
                    _InfoRow(label: "Routes", value: "0"),
                  ],
                ),
              ],
            ),
          ),
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
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUnitManager(),));
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

  Widget _buildCard({
    required String title,
    required List<Color> gradientColors,
    required List<_InfoRow> rows,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        
        border: Border.all(
          width: 2
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, offset: Offset(2, 2), blurRadius: 15),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(children: rows),
          )
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const Text(":", style: TextStyle(fontSize: 15)),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
