import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/ai_chat/controllers/ai_chat_controller.dart';
import 'package:sheshya/app/modules/teacher/ai_chat/controllers/speech_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class AiChatView extends StatefulWidget {
  final String? teacherImage;
  const AiChatView({super.key, this.teacherImage});

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  final speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiChatController>(
      builder: (chatController) => Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text('Sheshya AI'),
          actions: [
            IconButton(
              icon: Icon(Icons.report_outlined, color: AppColors.textColor),
              onPressed: () => _showReportIssueDialog(context),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: chatController.chatList.isEmpty
                  ? buildSampleQuestions(chatController)
                  : ListView.builder(
                      controller: chatController.scrollController,
                      itemCount: chatController.chatList.length,
                      padding: const EdgeInsets.all(Dimensions.defaultPadding),
                      itemBuilder: (context, index) {
                        final msg = chatController.chatList[index];
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: index == chatController.chatList.length - 1 ? 0 : 12.h,
                          ),
                          child: msg.isCreatedByMe
                              ? _buildUserMessage(msg.message)
                              : _buildAiMessage(msg.message),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showReportIssueDialog(context),
                  child: Text(
                    'Report for any issue!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 66, 143, 202),
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color.fromARGB(255, 66, 143, 202),
                    ),
                  ),
                ),
              ),
            ),
            _buildMessageInput(chatController),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMessage(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Container(
        //   width: 20.w,
        //   height: 15.w,
        //   decoration: BoxDecoration(
        //     color: AppColors.accentColor,
        //     borderRadius: BorderRadius.circular(100.r),
        //     image: widget.teacherImage == null
        //         ? null
        //         : DecorationImage(
        //             image: NetworkImage(widget.teacherImage ?? ''),
        //             fit: BoxFit.fitWidth,
        //           ),
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
            border: Border.all(color: const Color(0xFFEAEAEA), width: 1.w)
          ),
          // width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.all(8.w),
          child: Text(
            message,
            style: kDark_14_400,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildAiMessage(String message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          Assets.logo,
          width: 24.w,
        ),
        Markdown(
          physics: const NeverScrollableScrollPhysics(),
          selectable: false,
          shrinkWrap: true,
          data: message,
        ),
      ],
    );
  }

  Widget _buildMessageInput(AiChatController chatController) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Plus Icon
          // Container(
          //   height: 40,
          //   width: 40,
          //   decoration: BoxDecoration(
          //     // shape: BoxShape.circle,
          //     color: Colors.transparent,
          //   ),
          //   child: Icon(Icons.add, color: Colors.grey.shade500),
          // ),

          const SizedBox(width: 8),

          // TextField
          Expanded(
            child: TextField(
              focusNode: chatController.messageFocusNode,
              readOnly: chatController.isLoading,
              controller: chatController.messageController,
              keyboardType: TextInputType.multiline,
              // maxLines: 3,
              // minLines: 1,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                hintText: 'Message Sheshya AI',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Mic Icon
          GetBuilder<SpeechController>(
            builder: (speech) => GestureDetector(
              onTap: () async {
                if (speech.isListening) {
                  speech.stopListening();
                } else {
                  final text = await speech.startListening();
                  if (text.isNotEmpty) {
                    chatController.setMessageText(
                      "${chatController.messageController.text} $text",
                    );
                  }
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: speech.isListening
                      ? SizedBox(
                          height: 18,
                          width: 18,
                          child: const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          CupertinoIcons.mic,
                          color: Colors.grey.shade600,
                          size: 25,
                        ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Send Icon
          chatController.isLoading
              ? const SizedBox(
                  height: 38,
                  width: 38,
                  child: CircularProgressIndicator(
                    color: AppColors.accentColor,
                    strokeWidth: 2,
                  ),
                )
              : GestureDetector(
                  onTap: () => chatController.sendMessage(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
        ],
      ),
    ),
  );
}


//   Widget _buildMessageInput(AiChatController chatController) {
//   return Padding(
//     padding: const EdgeInsets.all(Dimensions.defaultPadding),
//     child: TextField(
//       focusNode: chatController.messageFocusNode,
//       readOnly: chatController.isLoading,
//       controller: chatController.messageController,
//       keyboardType: TextInputType.multiline,
//       maxLines: 3,
//       minLines: 1,
//       onTapOutside: (event) => FocusScope.of(context).unfocus(),
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(
//             color: const Color(0xFFEAEAEA),
//             width: 2.w,
//           ),
//         ),
//         hintText: 'Ask Sheshya',
//         hintStyle: kSecondary_14_400,
//         prefixIcon: GetBuilder<SpeechController>(
//           builder: (speech) => GestureDetector(
//             onTap: () async {
//               if (speech.isListening) {
//                 speech.stopListening();
//               } else {
//                 final text = await speech.startListening();
//                 if (text.isNotEmpty) {
//                   chatController.setMessageText(
//                     "${chatController.messageController.text} $text",
//                   );
//                 }
//               }
//             },
//             child: Container(
//               height: 48.w,
//               width: 48.w,
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(100.r),
//               ),
//               child: speech.isListening
//                   ? const CircularProgressIndicator(
//                       color: AppColors.primaryColor,
//                       strokeWidth: 2,
//                     )
//                   : Icon(
//                       CupertinoIcons.mic_fill,
//                       color: AppColors.primaryColor,
//                       size: 24.w,
//                     ),
//             ),
//           ),
//         ),
//         suffixIcon: chatController.isLoading
//             ? Container(
//                 margin: const EdgeInsets.all(8.0),
//                 child: const CircularProgressIndicator(
//                   color: AppColors.accentColor,
//                 ),
//               )
//             : GestureDetector(
//                 onTap: () => chatController.sendMessage(),
//                 child: SvgPicture.asset(
//                   Assets.aiChat,
//                 ),
//               ),
//       ),
//     ),
//   );
// }

Widget buildSampleQuestions(AiChatController chatController) {
  final String displayName = Get.find<TeacherProfileController>().displayName;

  final List<String> questions = [
    "How does Pythagoras Theorem work?",
    "How do animals produce energy?",
    "What is the difference b/w Velocity and Speed?",
  ];

  return Padding(
    
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting
        RichText(
          text: TextSpan(
            text: "Hey, ",
            style: TextStyle(
              fontSize: 28,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: displayName,
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF8A49FF), // Purple tone
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Subheading
        const Text(
          "I can answer all your\nCuriosities",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 28),

        // Questions List
        Column(
          children: questions.map((question) {
            return GestureDetector(
              onTap: () {
                chatController.sendMessage(msg: question);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFEAEAEA)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(Icons.lightbulb_outline, color: Colors.grey.shade600),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}


  void _showReportIssueDialog(BuildContext context) {
    final TextEditingController reportController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Report an Issue"),
        content: TextField(
          controller: reportController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Describe the issue...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final issue = reportController.text;
              if (issue.isNotEmpty) {
                Navigator.pop(context);
                Get.snackbar("Issue Reported", "Thank you for your feedback!");
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}