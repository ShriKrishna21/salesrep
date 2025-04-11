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
                      child: ListTile(
                        title: Text(customer.familyHeadName ?? 'No name'),
                        subtitle: Text("ID: ${customer.id.toString() ?? 'N/A'}"),
                      ),
                    );
                  },
                ),
    );
  }
}
