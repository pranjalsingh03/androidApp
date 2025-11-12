import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

import '../controllers/error_controller.dart';

class ErrorView extends GetView<ErrorController> {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          // Error Illustration
          SvgPicture.asset(
            'assets/images/error_view.svg',
            height: 150,
          ),
          const SizedBox(height: 20),
          
          // Error Message
          Text(
            "Oops! Something went wrong",
            style: kDark_14_500,
            textAlign: TextAlign.center,
          ),
          
          const Spacer(),
          
          // Retry Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => restartApp(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Exit',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to Restart the App
  void restartApp() {
    Get.reset(); // Reset GetX Controllers
    exit(0); // Forcefully restart the app
  }
}