import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/helper/custom_print.dart';

import 'ai_result.dart';

class ExamsPage extends StatefulWidget {
  final String subjectId;

  const ExamsPage({Key? key, required this.subjectId}) : super(key: key);

  @override
  _ExamsPageState createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  List<ExamModel> exams = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchExams();
  }

  Future<void> fetchExams() async {
    final token = GetStorage().read('token'); // Replace with actual token key
    const url =
        'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/getPerformanceTestsBySubject';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'subjectId': widget.subjectId}),
      );
      customPrint('Response: ${widget.subjectId}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        customPrint('Response: $jsonResponse');

        if (jsonResponse['success']) {
          setState(() {
            exams = (jsonResponse['data'] as List)
                .map((item) => ExamModel.fromJson(item))
                .toList();
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to fetch exams';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const AppBarBackButton(),
        title: const Text(
          'AI Exams',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exams Count Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFEAEAEA)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${exams.length}', // Dynamic count
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Exams',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Exams',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: Loader(text: "Loading Exams...",)) // Show loader
                : errorMessage.isNotEmpty
                ? Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            )
                : exams.isEmpty
                ? const Center(
              child: Text('No exams available'),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return _buildQuizItem(exam);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizItem(ExamModel exam) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => AiResultPage(
            testName: exam.testName,
            rightAnswer: exam.right.toString(),
            wrongAnswer: exam.wrong.toString(),
            notAttempted: exam.unattempted.toString(),
            weakness: exam.weakness,
            suggestion: exam.suggestions,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFEAEAEA)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'AI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(exam.testName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          subtitle: Text(
            'Marks: ${exam.marksObtained}/${exam.totalMarks}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ExamModel {
  final String id;
  final String testName;
  final int marksObtained;
  final int totalMarks;
  final int right;
  final int wrong;
  final int unattempted;
  final List<String> weakness;
  final List<String> suggestions;

  ExamModel({
    required this.id,
    required this.testName,
    required this.marksObtained,
    required this.totalMarks,
    required this.right,
    required this.wrong,
    required this.unattempted,
    required this.weakness,
    required this.suggestions,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] ?? '',
      testName: json['testName'] ?? '',
      marksObtained: json['marksObtained'] ?? 0,
      totalMarks: json['totalMarks'] ?? 0,
      right: json['right'] ?? 0,
      wrong: json['wrong'] ?? 0,
      unattempted: json['unattempted'] ?? 0,
      weakness: json['analysis']['weakness'] is List
          ? List<String>.from(json['analysis']['weakness'])
          : [json['analysis']['weakness'] ?? 'Weakness not available'],
      suggestions: json['analysis']['suggestions'] is List
          ? List<String>.from(json['analysis']['suggestions'])
          : [json['analysis']['suggestions'] ?? 'Suggestions not available'],
    );
  }
}