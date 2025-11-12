import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/teacher/response/current_class_model.dart';
import 'package:sheshya/app/modules/teacher/timetable/views/timetable_screen.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/theme/app_colors.dart';

class UpcomingClassSectionCard extends StatelessWidget {
  final CurrentClassModel? currentClass;
  const UpcomingClassSectionCard({
    super.key,
    required this.currentClass,
  });

  @override
  Widget build(BuildContext context) {
    return currentClass == null
        ? ListTile(
            splashColor: Colors.transparent,
            onTap: () => Get.to(() => const TeacherTimetableScreen()),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(width: 1, color: AppColors.strokeColor )),
            contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
            tileColor: Colors.white,
            title: Text(
              'No Classes Right Now',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Sit Relax',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.secondaryTextColor),
            ),
            leading: const CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                CupertinoIcons.zzz,
                color: Colors.white,
              ),
            ),
            trailing: SvgPicture.asset(
              Assets.arrowRight,
              colorFilter:
                  const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
            ),
          )
        : ListTile(
            onTap: () => Get.to(() => const TeacherTimetableScreen()),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
            tileColor: Colors.white,
            title: Text(
              'Class ${currentClass!.className.className} ${currentClass!.className.section}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${currentClass!.period.name}, ${currentClass!.period.startTime} - ${currentClass!.period.endTime}, ${currentClass!.subject.subjectName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.secondaryTextColor),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Text(
                '${currentClass!.className.className} ${currentClass!.className.section}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
            trailing: SvgPicture.asset(
              Assets.arrowRight,
              colorFilter:
                  const ColorFilter.mode(AppColors.textColor, BlendMode.srcIn),
            ),

            // trailing: const Icon(
            //   Icons.more_vert,
            //   color: textaccentColor,
            //   size: Dimensions.defaultPadding,
            // ),
          );
  }
}
