import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

import '../../../../constants/styles.dart';
import '../../../../helper/system_ui.dart';
import 'parenting_notification_controller.dart';

class ParentNotificationScreen extends StatelessWidget {
  static const routeName = "/parent-notice";

  ParentNotificationScreen({super.key});

  final ParentingNotificationController controller =
      Get.put(ParentingNotificationController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: Dimensions.defaultPadding,
            ),
          ),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          child: Obx(() => buildBody(context)),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    if (controller.isNLoading.value.isLoading) {
      return const Center(
        child: Loader(text: "Loading Notifications"),
      );
    } else if (controller.isNLoading.value.isError) {
      return GestureDetector(
        onTap: () {
          controller.loadNotification();
        },
        child: const Center(
          child: Text(
            'Retry',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      );
    } else {
      final notifications = controller.getNotificationStudentsResModel?.data;
      notifications?.sort((a, b) {
        return DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!));
      });

      return ListView.builder(
        itemCount: notifications?.length ?? 0,
        itemBuilder: (context, index) {
          final notification = notifications?[index];
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
                        notification?.title ?? '',
                        style: kDark_14_500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${notification?.time ?? ''} | ${notification?.date ?? ''}",
                      style: kDark_10_400.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  notification?.message ?? '',
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
      );
    }
  }
}