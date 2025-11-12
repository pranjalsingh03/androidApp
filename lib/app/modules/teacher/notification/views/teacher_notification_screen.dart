import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_notification_model.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_notification_repo.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import '../../../../../theme/app_colors.dart';

class TeacherNotificationScreen extends StatefulWidget {
  const TeacherNotificationScreen({super.key});

  @override
  State<TeacherNotificationScreen> createState() =>
      _TeacherNotificationScreenState();
}

class _TeacherNotificationScreenState extends State<TeacherNotificationScreen> {
  bool isLoading = true;
  List<TeacherNotificationData> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final data =
          await TeacherNotificationRepository.getTeacherAllNotification();
      setState(() {
        notifications = data.data;
        isLoading = false;
      });
    } catch (e) {
      showCustomSnackBar("Unable to get notifications");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Notification"),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Center(
                  child: Loader(
                  text: "Getting Notifications",
                ))
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(width: 1, color: AppColors.strokeColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  notification.title,
                                  style: kDark_14_500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                notification.date,
                                style: kDark_10_400.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                          k12YGap,
                          Text(
                            notification.message,
                            style: kDark_10_400.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}