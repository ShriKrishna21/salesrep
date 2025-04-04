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

  Future<void> datasaved() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('apikey');
    final int? userId = prefs.getInt('id');

    print('API Key: $apiKey');
    print('User ID: $userId');

    try {
      const url = 'http://10.100.13.138:8099/api/customer_forms_info';

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "params": {
            "user_id": userId.toString(),
            "token": apiKey.toString(),
          }
        }),
      );

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final Historymodel model = Historymodel.fromJson(jsonResponse);

        if (model.result?.code == "200") {
          setState(() {
            history = model;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid data received")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (error) {
      print("Something went wrong: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred")),
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
                        title: Text("Family Head: ${record.familyHeadName}"),
                        subtitle: Text("City: ${record.city}\nMobile: ${record.mobileNumber}"),
                        trailing: Text(record.date),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No data found")),
    );
  }
}
