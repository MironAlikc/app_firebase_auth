import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  final storage = FlutterSecureStorage();
  String? email;
  initStorage() async {
    email = await storage.read(key: 'email');
    setState(() {});
    //print(email);
  }

  @override
  void initState() {
    initStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(email ?? ''),
      ),
    );
  }
}
