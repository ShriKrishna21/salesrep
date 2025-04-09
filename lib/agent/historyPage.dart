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

    print(' API Key: $apiKey');
    print(' User ID: $userId');

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

      print(' Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final Historymodel model = Historymodel.fromJson(jsonResponse);

        print(' Response JSON: ${jsonEncode(jsonResponse)}');

        if (model.result?.code == "200") {
          setState(() {
            history = model;
          });
          print("Data loaded successfully.");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(" Invalid data: ${model.result?.records ?? 'Unknown error'}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(" Server Error: ${response.statusCode}")),
        );
      }
    } on TimeoutException {
      print(" Request timed out.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request timed out")),
      );
    } on http.ClientException catch (e) {
      print(" ClientException: $e");
      if (!retrying) {
        print(" Retrying request...");
        await Future.delayed(const Duration(seconds: 2));
        await datasaved(retrying: true);
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connection error. Please try again.")),
      );
    } catch (error) {
      print(" Unexpected error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("An unexpected error occurred.")),
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
    datasaved(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : history?.result?.records != null
              ? ListView.builder(
                  itemCount: history!.result!.records.length,
                  itemBuilder: (context, index) {
                    final record = history!.result!.records[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(" Family Head: ${record.familyHeadName}"),
                        subtitle: Text(
                          " City: ${record.city}\n Mobile: ${record.mobileNumber}",
                        ),
                        trailing: Text(" ${record.date}"),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No data found")),
    );
  }
}
