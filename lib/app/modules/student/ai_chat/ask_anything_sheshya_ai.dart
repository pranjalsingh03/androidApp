import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';
import 'package:sheshya/app/modules/teacher/ai_chat/controllers/ai_chat_controller.dart';
import 'package:sheshya/app/modules/teacher/ai_chat/controllers/speech_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class AskAnythingSheshyaAiView extends StatefulWidget {
  final String? teacherImage;
  const AskAnythingSheshyaAiView({super.key, this.teacherImage});

  @override
  State<AskAnythingSheshyaAiView> createState() => _AskAnythingSheshyaAiViewState();
}

class _AskAnythingSheshyaAiViewState extends State<AskAnythingSheshyaAiView> {
  final speechController = Get.put(SpeechController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiChatController>(
      builder: (chatController) => Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text('Sheshya AI'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.report_outlined, color: AppColors.textColor),
                    onPressed: () => _showReportIssueDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                child: (chatController.chatList.isEmpty)
                    ? buildSampleQuestions(chatController)
                    : ListView.builder(
                        controller: chatController.scrollController,
                        itemCount: chatController.chatList.length,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(Dimensions.defaultPadding),
                        itemBuilder: (context, index) {
                          final msg = chatController.chatList[index];
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: index == chatController.chatList.length - 1 ? 0 : 12.h),
                            child: msg.isCreatedByMe
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 24.w,
                                        height: 24.w,
                                        // decoration: BoxDecoration(
                                        //   color: AppColors.accentColor,
                                        //   borderRadius: BorderRadius.circular(100.r),
                                        //   image: widget.teacherImage == null
                                        //       ? null
                                        //       : DecorationImage(
                                        //           image: NetworkImage(widget.teacherImage ?? ''),
                                        //           fit: BoxFit.fitWidth,
                                        //         ),
                                        // ),
                                      ),
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
            msg.message,
            style: kDark_14_400,
            textAlign: TextAlign.right,
          ),
        ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.logo,
                                        width: 24.w,
                                      ),
                                      Markdown(
                                        physics: const NeverScrollableScrollPhysics(),
                                        selectable: false,
                                        shrinkWrap: true,
                                        data: msg.message,
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding, vertical: 0),
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
              // TextField
              Padding(
    padding: const EdgeInsets.all(Dimensions.defaultPadding),
    child: TextField(
      focusNode: chatController.messageFocusNode,
      readOnly: chatController.isLoading,
      controller: chatController.messageController,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      minLines: 1,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: const Color(0xFFEAEAEA),
            width: 2.w,
          ),
        ),
        hintText: 'Ask Sheshya',
        hintStyle: kSecondary_14_400,
        prefixIcon: GetBuilder<SpeechController>(
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
              height: 48.w,
              width: 48.w,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: speech.isListening
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2,
                    )
                  : Icon(
                      CupertinoIcons.mic_fill,
                      color: AppColors.primaryColor,
                      size: 24.w,
                    ),
            ),
          ),
        ),
        suffixIcon: chatController.isLoading
            ? Container(
                margin: const EdgeInsets.all(8.0),
                child: const CircularProgressIndicator(
                  color: AppColors.accentColor,
                ),
              )
            : GestureDetector(
                onTap: () => chatController.sendMessage(),
                child: SvgPicture.asset(
                  Assets.aiChat,
                ),
              ),
      ),
    ),
  )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSampleQuestions(AiChatController chatController) {
    final ParentHomeController controller = Get.find();

  final List<String> questions = [
    "How does Pythagoras Theorem work?",
    "How do animals produce energy?",
    "What is the difference between Velocity and Speed?",
  ];

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Centered Gradient Title
        Expanded(
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color(0xFF2C87FF),
                  Color(0xFFC904FF),
                  Color(0xFFA622FF),
                  Color(0xFFFEBE16),
                  Color(0xFFFFC014),
                ],
              ).createShader(bounds),
              child: Text(
                "Hello ${controller.nameController.text}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Required for ShaderMask
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),

        // Bottom Slider with Dummy Questions
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 120, // Adjust height as needed
            // width: 300, // Adjust width as needed
            child: PageView.builder(
              itemCount: questions.length,
              controller: PageController(viewportFraction: 0.85),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    chatController.sendMessage(msg: questions[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xffEAEAEA)),
                    ),
                    child: Center(
                      child: Text(
                        questions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
              // Handle the submission of the issue
              final issue = reportController.text;
              if (issue.isNotEmpty) {
                // Submit the issue
                // For example, you can send the issue to the server
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

class CuriosityCard extends StatelessWidget {
  final String question;

  const CuriosityCard({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.white,
      elevation: 1,
      child: ListTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        trailing: Icon(
          Icons.lightbulb_outline,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}