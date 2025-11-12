import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/teacher_chatbox_controller.dart';

class TeacherChatboxView extends GetView<TeacherChatboxController> {
  const TeacherChatboxView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TeacherChatboxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TeacherChatboxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
