import 'package:flutter/material.dart';
import 'package:sheshya/constants/styles.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;
  const ErrorScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          message ?? "Something went wrong!",
          style: kDark_12_400.copyWith(color: Colors.red),
        ),
      ),
    );
  }
}
