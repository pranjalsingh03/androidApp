import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class StudentDetailsView extends StatelessWidget {
  final String studentId;
  final String assignmentId;
  final String studentName;

  const StudentDetailsView({required this.studentId, required this.assignmentId, required this.studentName, super.key});

  Future<Map<String, dynamic>> fetchStudentPerformance(String studentId, String assignmentId) async {
    final apiClient = ApiClient();
    final response = await apiClient.post(
      '/teacher/getStudentPerformanceInAssignment',
      {'studentId': studentId, 'assignmentId': assignmentId},
      passToken: true,
      baseUrl: ApiConstants.apiBaseUrlNew,
    );

    if (response.statusCode == 200) {
      return response.body['data'];
    } else {
      throw Exception('Failed to load student performance');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text("$studentName's Result"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchStudentPerformance(studentId, assignmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Loader(text: "Loading Student Performance"));
          } else if (snapshot.hasError) {
            return Center(child: Text('No Details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final performance = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildScoreCard("Correct", performance['right'].toString(), Colors.blue),
                      _buildScoreCard("Wrong", performance['wrong'].toString(), Colors.grey),
                      _buildScoreCard("Ranking", "#${performance['rank']}", Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("Improvements", style: kDark_16_500),
                  const SizedBox(height: 10),
                  ...performance['improvement'].map<Widget>((improvement) => _buildSuggestionCard(improvement)).toList(),
                  const SizedBox(height: 20),
                  Text("Just for you | Suggestions", style: kDark_16_500),
                  const SizedBox(height: 10),
                  ...performance['advice'].map<Widget>((advice) => _buildSuggestionCard(advice)).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildScoreCard(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(width: 0.5, color: Colors.grey.shade300),
          ),
          child: SizedBox(
            height: 30,
            width: 75,
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSuggestionCard(String text, {IconData? icon}) {
    return Card(
      shadowColor: Colors.transparent,
      borderOnForeground: true,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.blue) : null,
        title: Text(text, style: kDark_14_400),
      ),
    );
  }
}