import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheshya/app/data/model/ui_models/coming_soon_screen.dart';
import 'package:sheshya/app/modules/parent/profile/parent_feedback_screen.dart';
import 'package:sheshya/app/modules/parent/profile/parent_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/logout_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/misc/views/support_screen.dart';
import 'package:sheshya/app/modules/student/edit_profile/edit_profile_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';

import '../../../../constants/pref_constants.dart';
import '../../../../helper/class_helper.dart';
import '../../auth/views/onboarding_view.dart';
import '../../misc/views/email_support_screen.dart';
import '../parent_home/parent_home_controller.dart';

class ParentProfileScreen extends StatefulWidget {
  static const routeName = "/parent-profile";
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(ParentProfileController());

    final ParentHomeController parentHomeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: const AppBarBackButton(),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    studentDetailCard(parentHomeController),
                    const SizedBox(height: 25),
                    homeActionCard(),
                    const SizedBox(height: 20),
                    settingTile(
                      title: "Customer Support",
                      onPress: () => Get.to(() => const EmailSupportScreen()),
                    ),
                    settingTile(
                      title: "Feedback",
                      onPress: () {
                        Get.to(ParentFeedbackScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            settingTile(
              title: "Log out",
              onPress: () => Get.to(() => const LogoutScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTile({required String title, required VoidCallback onPress}) {
    final isLogout = title.toLowerCase() == "log out";
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: isLogout ? UiConstants.defaultProfileDecoration : UiConstants.defaultDecoration,
      child: GestureDetector(
        onTap: onPress,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: isLogout ? UiConstants.dark_14_log500 : UiConstants.darkk_14_500,
              ),
            ),
            SvgPicture.asset(
              Assets.arrowRight,
              width: 24,
              colorFilter: ColorFilter.mode(
                isLogout ? AppColors.whiteColor : AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget studentDetailCard(ParentHomeController parentHomeController) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(EditProfileScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: DottedBorder(
                borderType: BorderType.Circle,
                strokeWidth: 2,
                dashPattern: const [10],
                strokeCap: StrokeCap.round,
                color: AppColors.primaryColor.withOpacity(.1),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: parentHomeController?.studentProfileResModel?.data?.basic?.imageUrl != null &&
                      parentHomeController.studentProfileResModel?.data?.basic?.imageUrl?.isNotEmpty == true
                    ? Image.network(
                      parentHomeController.studentProfileResModel?.data?.basic?.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    )
                    : Image.asset(
                      AssetsConstants.userAvatar,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                ),
              ),
            ),
          ),
          // Bio
          Text(
            parentHomeController?.studentProfileResModel?.data?.basic?.name ?? '--',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: kFontFamily,
              color: AppColors.textColor,
            ),
          ),
          Text(
            "Class ${(parentHomeController?.studentProfileResModel?.data?.academic?.className ?? '')} | Section - ${parentHomeController?.studentProfileResModel?.data?.academic?.section ?? ''}",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontFamily: kFontFamily,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Row homeActionCard() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(EditProfileScreen());
            },
            child: Container(
              height: 188,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: SvgPicture.asset(AssetsConstants.achievements)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Data Input",
                        style: UiConstants.dark_14_600,
                      ),
                      SvgPicture.asset(Assets.arrowRight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(() => ComingSoonScreen());
            },
            child: Container(
              height: 188,
              width: (Get.width - 32 - 19) / 2,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SvgPicture.asset(AssetsConstants.discipline),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Discipline Record",
                        style: TextStyle(
                          color: AppColors.bodyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SvgPicture.asset(Assets.arrowRight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}