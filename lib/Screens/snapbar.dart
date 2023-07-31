import 'package:flutter/material.dart';

class ShowSnackBarExampleApp extends StatelessWidget {
  const ShowSnackBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ScaffoldMessengerState Sample')),
        body: Center(
          child: ShowSnackBar(
            content: Text("sdxc"),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ShowSnackBar extends StatelessWidget {
  ShowSnackBar({super.key, required this.content});

  Widget content;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            content: content,
          ),
        );
      },
      child: const Text('Show SnackBar'),
    );
  }
}
