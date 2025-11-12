import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/widgets/leave_card.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';

class TeacherAllLeavesScreen extends StatefulWidget {
  const TeacherAllLeavesScreen({super.key});

  @override
  State<TeacherAllLeavesScreen> createState() => _TeacherAllLeavesScreenState();
}

class _TeacherAllLeavesScreenState extends State<TeacherAllLeavesScreen> {
  final TeacherProfileController _teacherProfileController =
      Get.find<TeacherProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _teacherProfileController.getTeacherAllLeaves();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Leave Details'),
      ),
      body: GetBuilder<TeacherProfileController>(
        builder: (controller) {
          if (controller.isGettingLeaves) {
            return const Center(child: Loader(text: "Getting leaves"));
          } else if (controller.leavesResponse == null) {
            return const Center(child: Text('No leaves found'));
          } else {
            // Sort the leaves by date in descending order
            final sortedLeaves = controller.leavesResponse!.data
              ..sort((a, b) => b.date.compareTo(a.date));

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedLeaves.length,
                itemBuilder: (context, index) {
                  return LeaveCard(
                    leave: sortedLeaves[index],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}