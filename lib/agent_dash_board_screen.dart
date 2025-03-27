import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesrep/coustmerform.dart';
import 'package:salesrep/coustmermodel.dart';

class AgentDashBoardScreen extends StatefulWidget {
  const AgentDashBoardScreen({super.key});

  @override
  State<AgentDashBoardScreen> createState() => _AgentDashBoardScreenState();
}

class _AgentDashBoardScreenState extends State<AgentDashBoardScreen> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentDateTime();

    // getCurrentLocation();
    // fetchAlbum();
  }

  void getCurrentDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEE-MM-dd-yyyy ").format(now);
    setState(() {
      dateController.text = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 50,
             child:  Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
             
              ),
              child: IconButton(onPressed: (){}, icon: Icon(Icons.person)),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Sales Rep",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/logo.jpg"),
                fit: BoxFit.cover,
              ),
              GestureDetector(
                onTap: () {
                  print("object");
                },
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.stacked_bar_chart,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      "History Page",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> const Coustmer()));
        },
        label: const Text(
          "Customer Form",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        icon: const Icon(
          Icons.add_box_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),

            Container(
              height: 55,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade500),
              child: Center(
                child: Text(
                  dateController.text,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //1st Big Container
            Row(
              children: [
                Container(
                  height: 140,
                  width: 190,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      //   2nd  House Visited Container
                      Container(
                        height: 60,
                        width: 200,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.white),
                        child: const Center(
                            child: Text(
                          "House Visited",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                      //today Container
                      Container(
                        height: 80,
                        width: 200,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(

                                // topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            border: Border(
                                top: BorderSide(color: Colors.black, width: 2)),
                            color: Colors.lightGreenAccent),
                        child: const Center(
                            child: Text(
                          "Today:0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: 140,
                  width: 190,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      //   2nd  House Visited Container
                      Container(
                        height: 60,
                        width: 200,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(),
                            color: Colors.white),
                        child: const Center(
                            child: Text(
                          "Target Left",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                      //today Container
                      Container(
                        height: 80,
                        width: 200,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border(
                                top: BorderSide(color: Colors.black, width: 2)),
                            color: Colors.red),
                        child: const Center(
                          child: Text(
                            "Today:40",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            //My Root Map Container
            Column(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      //   2nd  House Visited Container
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: const Center(
                            child: Text(
                          "My Route Map",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                      //today Container
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border(
                                top: BorderSide(color: Colors.black, width: 2)),
                            color: Colors.deepPurple),
                        child: const Center(
                          child: Text(
                            "NA",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                            offset: Offset(5, 5))
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      //   2nd  House Visited Container
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: const Center(
                            child: Text(
                          "Reports",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                      //today Container
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1))
                            ],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border(
                                top: BorderSide(color: Colors.black, width: 2)),
                            color: Colors.orangeAccent),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Already Subscribed            :    0",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                "15 Days Offer Accepted     :    0",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                "15 Days Offer Rejected      :    0",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
