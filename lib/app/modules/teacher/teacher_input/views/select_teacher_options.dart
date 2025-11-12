import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/teacher_input/views/teacher_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_input/views/class_teacher_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';

class SelectTeacherOptions extends StatefulWidget {
  const SelectTeacherOptions({super.key});

  @override
  _SelectTeacherOptionsState createState() => _SelectTeacherOptionsState();
}

class _SelectTeacherOptionsState extends State<SelectTeacherOptions> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const AppBarBackButton()
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What's your role in the School?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            // const Text(
            //   //disply the school name
            //   // "School Name",
            //   style: TextStyle(fontSize: 14, color: Colors.grey),
            // ),
            const SizedBox(height: 20),
            _buildRoleOption("Class Teacher"),
            const SizedBox(height: 15),
            _buildRoleOption("Teacher"),
            const Spacer(),
            _buildContinueButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role) {
    bool isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              role,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: selectedRole != null
          ? () {
              if (selectedRole == "Teacher") {
                Get.to(() => const ScheduleScreen());
              } else {
                Get.to(() => const ClassScheduleScreen());
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedRole != null ? Colors.blue : Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 15),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Continue",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
