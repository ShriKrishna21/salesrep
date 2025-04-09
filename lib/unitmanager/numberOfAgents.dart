import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesrep/modelClasses/usersModel.dart'; // Ensure this file defines the Users & User model

class Numberofagents extends StatefulWidget {
  const Numberofagents({super.key});

  @override
  State<Numberofagents> createState() => _NumberofagentsState();
}

class _NumberofagentsState extends State<Numberofagents> {
  Users? users;
  bool isLoading = false;
  String? currentuserid;

  Future<void> usersdata() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('apikey');
    final int? id = prefs.getInt('id');
    currentuserid = id?.toString(); // Safe null check

    const String url = 'http://10.100.13.138:8099/api/users';

    print('🔑 API Key: $apiKey');

    if (apiKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing API Key")),
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
                "token": apiKey,
              }
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final allUsers = Users.fromJson(jsonResponse['result']);

        // Filter for user with id == id
        final filteredUsers = allUsers.users
            .where((user) => user.id == id)
            .toList();
                    prefs.setInt('userCount', filteredUsers.length);


        setState(() {
          users = Users(status: allUsers.status, users: filteredUsers);
          isLoading = false;
        });

        print("Loaded ${filteredUsers.length} user(s) with ID $id.");
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
  void initState() {
    super.initState();
    usersdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agents with ID ${currentuserid ?? 'N/A'}"), // Null-safe
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (users?.users.isEmpty ?? true)
              ? const Center(child: Text("No users found"))
              : ListView.builder(
                  itemCount: users?.users.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = users!.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user.name[0].toUpperCase()),
                      ),
                      title: Text(user.name),
                      subtitle: Text("Role: ${user.role}"),
                      trailing: Text(user.unitName ?? ''),
                    );
                  },
                ),
    );
  }
}
