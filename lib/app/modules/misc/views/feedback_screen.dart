import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/delete_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/theme/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final FocusNode _feedbackFocusNode = FocusNode();
  final TextEditingController _feedbackController = TextEditingController();
  bool isValidFeedback = false;
  int selectedRating = 4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _feedbackFocusNode.requestFocus();
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text('Feedback'),
        ),
        body: Container(
          width: Get.width,
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.defaultPadding),
                  decoration: kDefaultDecorationBordered,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Heading
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Feedback",
                            style: kDark_14_500,
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedRating = index + 1;
                                  });
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.only(left: 4),
                                  child: SvgPicture.asset(
                                    Assets.star,
                                    width: 18.w,
                                    height: 18.w,
                                    colorFilter: ColorFilter.mode(
                                      index < selectedRating
                                          ? AppColors.accentColor
                                          : AppColors.secondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      k20YGap,
                      // Review
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Review",
                            style: kDark_12_500,
                          ),
                          k8YGap,
                          TextField(
                            focusNode: _feedbackFocusNode,
                            controller: _feedbackController,
                            onChanged: (value) {
                              setState(() {
                                isValidFeedback = value.trim().isNotEmpty;
                              });
                            },
                            onTapOutside: (value) => Get.focusScope!.unfocus(),
                            keyboardType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 5,
                            style: kDark_12_400,
                            decoration: InputDecoration(
                              fillColor: AppColors.secondaryColor.withOpacity(0.2),
                              filled: true,
                              hintText: "Write your experience",
                              hintStyle: kSecondary_12_400,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.cardBorderColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      k20YGap,
                      GetBuilder<TeacherProfileController>(
                        builder: (controller) => controller.isSubmittingFeedback
                            ? const CircularProgressIndicator(
                                color: AppColors.accentColor,
                              )
                            : CustomButton(
                                buttonText: "Publish your feedback",
                                onPressed: isValidFeedback
                                    ? () async {
                                        final isFeedbackSubmitted =
                                            await controller.submitTeacherFeedback(
                                          stars: selectedRating.toString(),
                                          content: _feedbackController.text,
                                        );
                                        if (isFeedbackSubmitted) {
                                          _feedbackController.clear();
                                        }
                                      }
                                    : null,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:50*4.h),
              CustomButton(
                buttonText: "Delete Teacher",
                onPressed: () {
                  Get.to(()=>DeleteScreen(userType: 'teacher',));
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}