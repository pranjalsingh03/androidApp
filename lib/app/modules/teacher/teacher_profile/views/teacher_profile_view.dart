import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/misc/views/feedback_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_input/views/select_teacher_options.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/logout_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_attendance_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_edit_profile_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/widgets/avatar.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/widgets/option_tile.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/widgets/profile_detail.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/class_helper.dart';
import 'package:sheshya/helper/datetime_helper.dart';
import 'package:sheshya/app/modules/misc/views/support_screen.dart';
import 'package:sheshya/theme/app_colors.dart';

class TeacherProfileView extends StatelessWidget {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherProfileController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // Profile Image
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 8.h, horizontal: Dimensions.defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => const TeacherEditProfileScreen()),
                      child: AvatarComponent(
                          image: controller.teacherProfileModel!.imageUrl ?? 'https://via.placeholder.com/150'),
                    ),
                    // Bio
                    Text(
                      controller.teacherProfileModel!.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.textColor,
                      ),
                    ),

                    Text(
                      controller.teacherProfileModel!.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.secondaryTextColor),
                    ),
                    if (controller.teacherProfileModel?.isClassTeacher == true) 
  Text(
    controller.teacherProfileModel!.classDetails != null
        ? "${controller.teacherProfileModel!.role} ${(controller.teacherProfileModel!.classDetails!.sclassName)} ${controller.teacherProfileModel!.classDetails!.section}"
        : "${controller.teacherProfileModel!.role}",
    style: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.secondaryTextColor,
    ),
  )

                  ],
                ),
              ),
              k10YGap,
              // Details
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 8.h, horizontal: Dimensions.defaultPadding),
                decoration: kDefaultDecoration,
                child: Column(
                  children: [
                    ProfileDetail(
                      title: "Contact Detail:",
                      value: controller.teacherProfileModel!.phoneNo,
                    ),
                    ProfileDetail(
                      title: "DOB:",
                      value: DateTimeHelper.ddmmyyyy(
                          date: controller.teacherProfileModel!.dob.toString()),
                    ),
                    ProfileDetail(
                      title: "Gender:",
                      value: controller.teacherProfileModel!.gender ??"",
                    ),
                    ProfileDetail(
                      title: "Joining Date:",
                      value: DateTimeHelper.ddmmyyyy(
                          date: controller.teacherProfileModel!.joiningDate
                              .toString()),
                    ),
                    ProfileDetail(
                      title: "Total Classes:",
                      value: controller.teacherProfileModel!.totalClasses?.toString() ?? '',
                    ),
                    ProfileDetail(
                      title: "Subjects:",
                      value: controller.teacherProfileModel!.teachSubject
                          .map((e) => e)
                          .join(", "),
                    ),
                  ],
                ),
              ),
              k20YGap,
              // Cards
              GestureDetector(
                onTap: () => Get.to(() => const TeacherAttendanceScreen()),
                child: Container(
                  height: 80.h,
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: Dimensions.defaultPadding),
                  decoration: ShapeDecoration(
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.defaultRoundedCorner),
                      ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Attendance",
                        style: kDark_14_500.copyWith(
                          color: AppColors.inverseTextColor,
                        ),
                      ),
                      SvgPicture.asset(Assets.profileAttendanceIcon),
                    ],
                  ),
                ),
              ),
              kdefaultYGap,
              OptionTile(
                title: "Data Input",
                onTap: () => Get.to(()=> const SelectTeacherOptions()),
              ),
              kdefaultYGap,
              OptionTile(
                title: "Customer Support",
                onTap: () => Get.to(() => const SupportScreen()),
              ),
              kdefaultYGap,
              OptionTile(
                title: "Feedback",
                onTap: () => Get.to(() => const FeedbackScreen()),
              ),
              kdefaultYGap,
              OptionTile(
                title: "Logout",
                textColor: AppColors.inverseTextColor,
                iconColor: AppColors.inverseTextColor,
                bgColor: AppColors.accentColor,
                onTap: () => Get.to(() => const LogoutScreen()),
              ),
              kdefaultYGap,
            ],
          ),
        ),
      ),
    );
  }
}
