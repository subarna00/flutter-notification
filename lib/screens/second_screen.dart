import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String payload;
  const SecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("second Screen"),
        centerTitle: true,
      ),
      body: Center(
          child: Text(
        payload,
        style: const TextStyle(fontSize: 30),
      )),
    );
  }
}
