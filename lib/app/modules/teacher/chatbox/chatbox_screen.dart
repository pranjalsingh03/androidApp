import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/app/modules/teacher/chatbox/chatbox_controller.dart';
import '../teacher_profile/controllers/teacher_profile_controller.dart';
import 'chatbox_chat_screen.dart';

class TeacherChatboxScreen extends GetView<ChatboxController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ChatboxController());

    // Load the list of students/users for chat
    controller.loadConnectedUsers();
    controller.connectToWebSocket();

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Chatbox'),
        scrolledUnderElevation: 0,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Obx(() => buildBody(context)),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (controller.isLoadingConnectedUsers.value) {
      return const Center(
        child: Loader(text: "Loading Students",),
      );
    } else if (controller.isLoadingConnectedUsers.value) {
      return Center(
        child: GestureDetector(
          onTap: () {
            controller.loadConnectedUsers();
          },
          child: const Text('Retry'),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // searchBox(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: controller.connectedUsers.length,
              itemBuilder: (context, index) {
                final student = controller.connectedUsers[index];
                return GestureDetector(
                  onTap: () {
                    navigateToChatScreen(student);
                  },
                  child: chatListTile(
                    iconPath: student['imageUrl'] ?? '',
                    name: student['name'] ?? 'Unknown',
                    className: student['className'] ?? 'N/A',
                    section: student['section'] ?? 'N/A',
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  void navigateToChatScreen(Map<String, String> student) {
  // final TeacherProfileController teacherProfileController =
  //     Get.find<TeacherProfileController>();

  // Clear previous messages
  controller.messages.clear();

  // Set the current user and recipient IDs
  // controller.currentUserId =
      // teacherProfileController.teacherProfileModel?.id ?? '';
  controller.recipientId = student['_id'] ?? ''; // Ensure '_id' is used correctly
  controller.recipientName = student['name'] ?? '';

  if (controller.recipientId.isEmpty) {
    Get.snackbar("Error", "Recipient ID is missing!");
    return;
  }

  // Start the chat session
  controller.startChatWithUser(controller.recipientId);

  // Navigate to the ChatboxChatScreen
  Get.to(() => ChatboxChatScreen());
}

  Container searchBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: UiConstants.defaultDecorationBordered,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            Assets.searchIcon,
            width: 18,
          ),
          const SizedBox(width: 15),
          const Text(
            "Search",
            style: UiConstants.secondary_14_400,
          ),
        ],
      ),
    );
  }

  Widget chatListTile({
    required String iconPath,
    required String name,
    required String className,
    required String section,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: UiConstants.defaultDecoration,
      child: Row(
        children: [
            Image.network(
            iconPath,
            width: 45,
            height: 45,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
              Icons.account_circle,
              size: 45,
              color: Colors.grey,
              );
            },
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  name,
                  style: UiConstants.dark_14_500,
                ),
                Text(
                  "Class $className $section",
                  style: UiConstants.secondary_10_400,
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            Assets.arrowRight,
            width: 28,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}