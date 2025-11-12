import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/teacher/chatbox/chatbox_controller.dart';

class ChatboxChatScreen extends StatefulWidget {
  @override
  _ChatboxChatScreenState createState() => _ChatboxChatScreenState();
}

class _ChatboxChatScreenState extends State<ChatboxChatScreen> {
  late Timer _timer;
  final ChatboxController controller = Get.find<ChatboxController>();

  @override
  void initState() {
    super.initState();
    // Load chat history immediately when the screen is opened
    controller.loadPastChats();
    // Start periodic updates for chat history
    _startPeriodicChatUpdates();
  }

  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    _timer.cancel();
    super.dispose();
  }

  void _startPeriodicChatUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.loadPastChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBarBackButton(),
        title: const Text('Chatbox'),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameBox(),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final chat = controller.messages[index];
                return buildChatMsg(
                  context,
                  chat['from'] ?? '',
                  chat['message'] ?? '',
                  chat['to'] ?? '',
                  chat['timestamp'] ?? '',
                );
              },
            ),
          ),
          buildMessageInput(context),
        ],
      );
  }

  Container NameBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: UiConstants.defaultDecorationBordered,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 15),
          Text(
            controller.recipientName,
            style: UiConstants.dark_16_500,
          ),
        ],
      ),
    );
  }

  Widget buildChatMsg(BuildContext context, String from, String msg, String to, String timestamp) {
  print('From: $from, To: $to, Msg: $msg, Timestamp: $timestamp');
  print(controller.currentUserId);

  // Format the timestamp
  final formattedTime = _formatTimestamp(timestamp);

  if (from == controller.currentUserId) {
    return senderMsg(context, msg, formattedTime); // Sent message
  } else {
    return receiverMsg(context, msg, formattedTime); // Received message
  }
}

Widget receiverMsg(BuildContext context, String msg, String time) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

Widget senderMsg(BuildContext context, String msg, String time) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            msg,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    ),
  );
}

String _formatTimestamp(String timestamp) {
  try {
    final dateTime = DateTime.parse(timestamp);
    final formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return '$formattedDate at $formattedTime';
  } catch (e) {
    print('Error formatting timestamp: $e');
    return '';
  }
}

  Widget buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: controller.messageFocusNode,
              readOnly: controller.isMessageSending.value,
              controller: controller.messageController,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFEAEAEA),
                    width: 1,
                  ),
                ),
                hintText: 'Write now...',
                hintStyle: kSecondary_14_400,
              ),
            ),
          ),
          const SizedBox(width: 8),
          controller.isMessageSending.value
              ? const CircularProgressIndicator(
                  color: AppColors.accentColor,
                )
              : GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (controller.messageController.text.trim().isNotEmpty) {
                      controller.sendMessage(controller.messageController.text);
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: AppColors.accentColor,
                    size: 24,
                  ),
                ),
        ],
      ),
    );
  }
}