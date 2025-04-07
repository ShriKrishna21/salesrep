import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesrep/modelClasses/historymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  Historymodel? history;
  bool isLoading = false;

  Future<void> datasaved({bool retrying = false}) async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('apikey');
    final int? userId = prefs.getInt('id');

    const String url = 'http://10.100.13.138:8099/api/customer_forms_info';

    print('🔑 API Key: $apiKey');
    print('👤 User ID: $userId');

    if (apiKey == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing API Key or User ID")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "params": {
                "user_id": userId.toString(),
                "token": apiKey,
              }
            }),
          )
          .timeout(const Duration(seconds: 20));

      print('✅ Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final Historymodel model = Historymodel.fromJson(jsonResponse);

        print('📦 Response JSON: ${jsonEncode(jsonResponse)}');

        if (model.result?.code == "200") {
          setState(() {
            history = model;
          });
          print("✅ Data loaded successfully.");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "⚠️ Invalid data: ${model.result?.records ?? 'Unknown error'}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Server Error: ${response.statusCode}")),
        );
      }
    } on TimeoutException {
      print("⏱️ Request timed out.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request timed out")),
      );
    } on http.ClientException catch (e) {
      print("🌐 ClientException: $e");
      if (!retrying) {
        print("🔁 Retrying request...");
        await Future.delayed(const Duration(seconds: 2));
        await datasaved(retrying: true);
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connection error. Please try again.")),
      );
    } catch (error) {
      print("🔥 Unexpected error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    datasaved(); // Fetch data when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: 
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : history?.result?.records != null
              ? ListView.builder(
                  itemCount: history!.result!.records.length,
                  itemBuilder: (context, index) {
                    final record = history!.result!.records[index];
                    return Card(
                      color: Colors.amber,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Family Head: ${record.familyHeadName}",
                              //  style: const TextStyle(fontWeight: FontWeight.bold  ),
                             
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Father: ${record.fatherName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Mother: ${record.motherName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Spouse: ${record.spouseName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("House No: ${record.houseNumber}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Street No: ${record.streetNumber}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("City: ${record.city}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Pincode: ${record.pinCode}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Address: ${record.address}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Mobile: ${record.mobileNumber}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Reads Eenadu: ${record.eenaduNewspaper ? 'Yes' : 'No'}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Feedback: ${record.feedbackToImproveEenaduPaper}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Reads Any Newspaper: ${record.readNewspaper ? 'Yes' : 'No'}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Current Newspaper: ${record.currentNewspaper}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Reason not taking Eenadu: ${record.reasonForNotTakingEenaduNewsPaper}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Reason not reading newspaper: ${record.reasonNotReading}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "15 Days Free Offer: ${record.freeOffer15Days ? 'Yes' : 'No'}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Reason not taking offer: ${record.reasonNotTakingOffer}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Employed: ${record.employed ? 'Yes' : 'No'}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Job Type: ${record.jobType}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Gov Dept: ${record.jobTypeOne}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Gov Profession: ${record.jobProfession}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Gov Designation: ${record.jobDesignation}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Company Name: ${record.companyName}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Private Position: ${record.profession}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Latitude: ${record.latitude}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Longitude: ${record.longitude}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Date: ${record.date}"),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No data found")),
    );
  }
}
