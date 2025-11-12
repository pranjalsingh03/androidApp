import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_notification_repo.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

import '../../../../../theme/app_colors.dart';

class TeacherNotificationDetailScreen extends StatefulWidget {
  final String notificationId;
  const TeacherNotificationDetailScreen(
      {super.key, required this.notificationId});

  @override
  State<TeacherNotificationDetailScreen> createState() =>
      _TeacherNotificationDetailScreenState();
}

class _TeacherNotificationDetailScreenState
    extends State<TeacherNotificationDetailScreen> {
  bool isLoading = true;
  Map<String, dynamic>? notification;

  @override
  void initState() {
    super.initState();
    getNotificationDetail();
  }

  Future<void> getNotificationDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await TeacherNotificationRepository.getTeacherNotification(
          notificationId: widget.notificationId);
      setState(() {
        notification = res['data'];
        isLoading = false;
      });
    } catch (e) {
      showCustomSnackBar("Unable to get notification details");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Notification"),
      ),
      body: isLoading
          ? const Center(
              child: Loader(
              text: "Getting Notification Detail",
            ))
          : notification == null
              ? const Center(
                  child: Text("Not Found"),
                )
              : Container(
                  margin: const EdgeInsets.all(Dimensions.defaultPadding),
                  padding: const EdgeInsets.all(Dimensions.defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),

                      border: Border.all(width: 1, color: AppColors.strokeColor )

                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification!['title'] ?? "",
                        style: kDark_16_500,
                      ),
                      k12YGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            notification!['date'] ??
                                // ignore: prefer_interpolation_to_compose_strings
                                " " + (notification!['time'] ?? ""),
                            style: kDark_10_400.copyWith(
                                fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "School Admin",
                            style: kDark_10_500,
                          ),
                        ],
                      ),
                      k18YGap,
                      Text(
                        notification!['message'] ?? "",
                        style: kDark_14_400.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.defaultPadding,
          right: Dimensions.defaultPadding,
          bottom: Dimensions.defaultPadding,
        ),
        child: CustomButton(
          buttonText: "Back to Homepage",
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
      ),
    );
  }
}
