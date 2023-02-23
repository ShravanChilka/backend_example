import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared/shared.dart' show User;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;
  late Client _client;

  @override
  void initState() {
    super.initState();
    _client = Client();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<User?> _fetchData() async {
    final response = await _client.get(
      Uri.parse('http://localhost:8080/'),
    );
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    } else {
      return null;
    }
  }
}
