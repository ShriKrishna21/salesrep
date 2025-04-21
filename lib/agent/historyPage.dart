import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesrep/modelClasses/onedayuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  onedayuser? oneDayUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchFormList();
  }

  Future<void> fetchFormList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('apikey');
    final int? userId = prefs.getInt('id');

    try {
      const url = 'http://10.100.13.138:8099/api/customer_forms_info_one_day';
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "params": {"user_id": userId.toString(), "token": apiKey}
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final forms = onedayuser.fromJson(jsonResponse);
        final customersList = forms.result?.records ?? [];

        prefs.setInt('customerFormCount', customersList.length);

        setState(() {
          oneDayUser = forms;
          isLoading = false;
        });
      } else {
        throw Exception('API error: ${response.statusCode}');
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred while fetching data.")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final customersList = oneDayUser?.result?.records ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("One Day Forms History"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : customersList.isEmpty
              ? const Center(child: Text("No data found."))
              : ListView.builder(
                  itemCount: customersList.length,
                  itemBuilder: (context, index) {
                    final customer = customersList[index];
                    return Card(
                      color: Colors.orange.shade200,
                      child: ListTile(
                        title: Text(
                          customer.familyHeadName ?? 'No name',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text("ID: ${customer.id.toString()}"),
                            Text(
                                "Agent Name: ${customer.agentName.toString()}"),
                            Text(
                                "Agent Login: ${customer.agentLogin.toString()}"),
                            Text("Unit Name: ${customer.unitName.toString()}"),
                            Text("Customer Date: ${customer.date.toString()}"),
                            Text("Customer Time: ${customer.time.toString()}"),
                            Text(
                                "Family Head Name: ${customer.familyHeadName.toString()}"),
                            Text(
                                "Father Name: ${customer.fatherName.toString()}"),
                            Text(
                                "Mother Name: ${customer.motherName.toString()}"),
                            Text(
                                "Spouse Name: ${customer.spouseName.toString()}"),
                            Text(
                                "House Number: ${customer.houseNumber.toString()}"),
                            Text(
                                "Street Number: ${customer.streetNumber.toString()}"),
                            Text("City: ${customer.city.toString()}"),
                            Text("PinCode: ${customer.pinCode.toString()}"),
                            Text("Address: ${customer.address.toString()}"),
                            Text(
                                "MobileNumber: ${customer.mobileNumber.toString()}"),
                            Text(
                                "Eenadu News Paper: ${customer.eenaduNewspaper.toString()}"),
                            Text(
                                "FeedBack To Improve Eenadu News Paper: ${customer.feedbackToImproveEenaduPaper.toString()}"),
                            Text(
                                "Read News Paper: ${customer.readNewspaper.toString()}"),
                            Text(
                                "Current News Paper: ${customer.currentNewspaper.toString()}"),
                            Text(
                                "Reason For Not Taking Eenadu News Paper: ${customer.reasonForNotTakingEenaduNewsPaper.toString()}"),
                            Text(
                                "Reason Not Reading: ${customer.reasonNotReading.toString()}"),
                            Text(
                                "Free Offer 15 Days: ${customer.freeOffer15Days.toString()}"),
                            Text(
                                "Reason Not Taking Offer: ${customer.reasonNotTakingOffer.toString()}"),
                            Text("Employed: ${customer.employed.toString()}"),
                            Text("Job Type: ${customer.jobType.toString()}"),
                            Text(
                                "Job Type One: ${customer.jobTypeOne.toString()}"),
                            Text(
                                "Job Profession: ${customer.jobProfession.toString()}"),
                            Text(
                                "Job Designation: ${customer.jobDesignation.toString()}"),
                            Text(
                                "Company Name: ${customer.companyName.toString()}"),
                            Text(
                                "Profession: ${customer.profession.toString()}"),
                            Text(
                                "Job Working State: ${customer.jobWorkingState.toString()}"),
                            Text(
                                "Job Working Location: ${customer.jobWorkingLocation.toString()}"),
                            Text(
                                "Job Designation One: ${customer.jobDesignationOne.toString()}"),
                            Text("Latitude: ${customer.latitude.toString()}"),
                            Text("Longitude: ${customer.longitude.toString()}"),
                            Text(
                                "Location Address: ${customer.locationAddress.toString()}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
