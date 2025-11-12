import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/ui_models/coming_soon_screen.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/student/notes/notes_screen.dart';
import 'package:sheshya/app/modules/student/ai_subject_selection/ai_subject_selection_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import '../../teacher/ai_chat/controllers/ai_chat_controller.dart';
import '../ai_chat/ask_anything_sheshya_ai.dart';

class AiScreen extends StatefulWidget {
  static const routeName = "/ai";
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            heroCard(),
            SizedBox(height: 16.h),
            actionCards(),
            SizedBox(height: 16.h),
            askAnythingCard()
          ],
        ),
      ),
    );
  }

  Container heroCard() {
    return Container(
      height: 381.h,
      width: Get.width,
      color: AppColors.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Learn",
              style: UiConstants.dark_18_400.copyWith(fontSize: 20.sp)),
          Text("Anything, Anytime",
              style: UiConstants.dark_18_400.copyWith(
                fontSize: 28.sp,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              )),
          SizedBox(height: 50.h),
          SvgPicture.asset(AssetsConstants.aiHeader),
        ],
      ),
    );
  }

  Container actionCards() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.to(()=>ComingSoonScreen()),
              child: Container(
                height: 180.h,
                decoration: UiConstants.defaultDecorationBordered,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(AssetsConstants.tutor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tutor",
                          style: UiConstants.dark_14_600,
                        ),
                        SvgPicture.asset(
                          Assets.arrowRight,
                          colorFilter: UiConstants.kSvgDarkFilter,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(NotesScreen());
              },
              child: Container(
                height: 180.h,
                decoration: UiConstants.defaultDecorationBordered,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(AssetsConstants.notes),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Notes",
                          style: UiConstants.dark_14_600,
                        ),
                        SvgPicture.asset(
                          Assets.arrowRight,
                          colorFilter: UiConstants.kSvgDarkFilter,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding askAnythingCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          // Get.toNamed(SubjectSelectionScreen.routeName)

          Get.find<AiChatController>().chatList.clear();
          Get.to(() => const AskAnythingSheshyaAiView());
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UiConstants.defaultRoundedCorner),
              ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Ask Anything!",
                style: UiConstants.dark_14_600
                    .copyWith(color: AppColors.inverseTextColor),
              ),
              SvgPicture.asset(AssetsConstants.ask),
            ],
          ),
        ),
      ),
    );
  }
}
