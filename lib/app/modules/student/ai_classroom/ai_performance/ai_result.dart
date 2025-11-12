import 'package:flutter/material.dart';
import 'package:sheshya/components/app_bar_back_button.dart';

class AiResultPage extends StatelessWidget {
  final String rightAnswer;
  final String wrongAnswer;
  final String notAttempted;
  final List<String> weakness;
  final List<String> suggestion;
  final String testName;

  const AiResultPage({
    super.key,
    required this.testName,
    required this.rightAnswer,
    required this.wrongAnswer,
    required this.notAttempted,
    required this.weakness,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const AppBarBackButton(),
        title: Text(
          testName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
              // Statistics Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xffEAEAEA)),
                ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E384D),
                  ),
                  ),
                  const SizedBox(height: 20),
                  _buildStatItem('Right Answer', rightAnswer, Colors.blue),
                  const SizedBox(height: 12),
                  _buildStatItem('Wrong Answer', wrongAnswer, Colors.grey),
                  const SizedBox(height: 12),
                  _buildStatItem('Not Attempted', notAttempted, Colors.orange),
                ],
                ),
              ),

              const SizedBox(height: 24),

              // Weakness Section
              const Text(
                'Weakness',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 12),
                Column(
                children: weakness.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffEAEAEA)),
                  ),
                  child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  ),
                )).toList(),
                ),

              const SizedBox(height: 24),

              // Suggestion Section
              const Text(
                'Suggestion',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E384D),
                ),
              ),
              const SizedBox(height: 12),
                Column(
                children: suggestion.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffEAEAEA)),
                  ),
                  child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  ),
                )).toList(),
                ),
              ],
            ),
            ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color dotColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF2E384D),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E384D),
          ),
        ),
      ],
    );
  }
}