import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sheshya/app/data/const_data/fee_data.dart';
import 'package:sheshya/app/modules/student/ai_classroom/test_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/main.dart';

class TestDetails extends StatelessWidget {
  final String id;
  final String image;
  final String chapterId;
  final String chapter;
  final String test;
  final String date;

  const TestDetails({super.key, required this.id, required this.image, required this.chapter, required this.test, required this.date, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(leading: AppBarBackButton(),title: Text(
        'Test Details',
        maxLines: 1,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis,
          color: Color(0xFF2F3542),
        ),
      ),backgroundColor: Color(0xFFF8F9FE),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              // Test Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFEAEAEA)),
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.05),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Row(
                  children: [
                    // Orange Triangle Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        image, // Replace with your actual image URL
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.change_history,
                            size: 40,
                            color: Colors.orange,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Test Information
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            chapter,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFFF7D1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Instructions Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFEAEAEA)),
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.05),
                  //     blurRadius: 10,
                  //     offset: const Offset(0, 2),
                  //   ),
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Instruction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lufga',
                        color: Color(0xFF374957),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Ensure a stable internet connection, and complete the test within the given time. Follow all guidelines, avoid unauthorized actions, and contact support if issues arise.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Start Test Button
              Container(
                width: double.infinity,
                height: 56,
                margin: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(TestScreen(testId: id,testName: test,));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start Test',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}