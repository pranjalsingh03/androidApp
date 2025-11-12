import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class DashboardViewClassroom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Math'),
              ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuizAssignedCard(),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
              children: [
                FeatureCard(title: "Quiz & Test", subtitle: "Get quizzes assigned by your teacher", color: Colors.amber, count: 4),
                FeatureCard(title: "Quick Notes", subtitle: "Chapter-wise high-quality notes", color: Colors.purple, count: 2),
                FeatureCard(title: "Flash Cards", subtitle: "Helps you quickly revise topics", color: Colors.blue, count: 0),
                FeatureCard(title: "Sheshya AI", subtitle: "Ask AI all your customized questions", color: Colors.grey, count: 0),
              ],
            ),
            SizedBox(height: 20),
            PerformanceSection(),
            SizedBox(height: 20),
            AITutorCard(),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              child: _buildWeaknessSection(),
            )
          ],
        ),
      ),
    );
  }
}

class QuizAssignedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quiz Assigned", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Linear Equation in Two Variables", style: TextStyle(color: Colors.grey)),
              Text("15 Questions - 30 Marks", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final int count;

  FeatureCard({required this.title, required this.subtitle, required this.color, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 5),
          Text(subtitle, style: TextStyle(color: Colors.white70)),
          Spacer(),
          if (count > 0)
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 10,
              child: Text(count.toString(), style: TextStyle(fontSize: 12, color: Colors.white)),
            )
        ],
      ),
    );
  }
}

class PerformanceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Performance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("Term 1 - Online"),
          SizedBox(height: 10),
          Text("Quiz 3 - 12/30 Marks", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AITutorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.deepPurple, Colors.black]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI Tutor.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          Text("Learn everything visually, your personalized tutor.", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text("Start for Free"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          )
        ],
      ),
    );
  }
}

Widget _buildTag(String text, {bool isSelected = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.grey[300],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}


Widget _buildWeaknessSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color:AppColors.strokeColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weakness",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildTag("Language Problem", isSelected: true),
            _buildTag("Confidence"),
            _buildTag("Math Concepts"),
            _buildTag("Biology"),
          ],
        ),
        SizedBox(height: 12),
        Text(
          "Struggles with comprehension and forming structured answers. Difficulty understanding complex exam questions.",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    ),
  );
}