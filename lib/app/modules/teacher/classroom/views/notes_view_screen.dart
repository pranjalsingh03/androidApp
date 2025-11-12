// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sheshya/app/data/model/teacher/response/subject_model.dart';
// import 'package:sheshya/app/data/respository/teacher/teacher_classroom_repo.dart';
// import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
// import 'package:sheshya/app/modules/teacher/classroom/views/notes_pdf_view.dart';
// import 'package:sheshya/constants/assets_constants.dart';
// import 'package:sheshya/constants/styles.dart';
// import 'package:sheshya/constants/ui_constants.dart';
// import 'package:sheshya/theme/app_colors.dart';

// class NotesViewScreen1 extends StatelessWidget {
//   final String className ;
//   final String subjectName;
//   final String chapterName;
//   final String topic;
//   final String title;

//   const NotesViewScreen1({
//     required this.className,
//     required this.subjectName,
//     required this.chapterName,
//     required this.topic,
//     required this.title,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final TeacherClassroomRepository controller =
//         Get.find<TeacherClassroomRepository>();
//     controller.generateNotes(
//       className: className,
//       subjectName: subjectName,
//       topics: topic,
//       chapterName:chapterName,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notesss'),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           width: Get.width,
//           height: Get.height,
//           child: ListView.builder(
//             itemCount: controller.selectedSubject!.chapters.length,
//             itemBuilder: (context, index) {
//               return noteTile(
//                 controller.selectedSubject!.chapters[index].chapterName,
//                 controller.selectedSubject!.chapters[index].topics.length,
//                 index,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Container noteTile(String chapterName, int topicsLength, int idx) {
//     final TeacherClassroomRepository controller =
//         Get.find<TeacherClassroomRepository>();
//     return Container(
//       height: 150.h,
//       margin: EdgeInsets.only(bottom: 16.h),
//       padding: EdgeInsets.all(10.w),
//       decoration: kDefaultDecoration,
//       child: Row(
//         children: [
//           Container(
//             width: 106.w,
//             margin: EdgeInsets.only(right: 10.w),
//             child: Image.asset(AssetsConstants.bulb),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 // Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         chapterName,
//                         style: kDark_14_600,
//                       ),
//                     ),
//                     Text(
//                       "Chapter ${idx + 1}",
//                       style: kDark_8_400.copyWith(
//                           fontSize: 8.sp, color: AppColors.tertiaryTextColor),
//                     ),
//                   ],
//                 ),
//                 // Subtitle
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       CupertinoIcons.star,
//                       color: AppColors.accentColor,
//                       size: 10.w,
//                     ),
//                     SizedBox(width: 5.w),
//                     Text(
//                       "$topicsLength Topics",
//                       style: kDark_12_400.copyWith(
//                           fontSize: 12.sp, color: AppColors.tertiaryTextColor),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 30.h),
//                   ),
//                   onPressed: () {
//                     Get.to(() => ChapterViewScreen(
//                           chapterName: chapterName,
//                           topics: controller.selectedSubject!.chapters[idx].topics,
//                         ));
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Text(
//                         "View topics",
//                         style: kLight_10_400,
//                       ),
//                       const Spacer(),
//                       Icon(
//                         CupertinoIcons.chevron_right,
//                         size: 10.w,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChapterViewScreen extends StatelessWidget {
//   final String chapterName;
//   final List<Topic> topics;

//   const ChapterViewScreen({
//     required this.chapterName,
//     required this.topics,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(chapterName),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           width: Get.width,
//           height: Get.height,
//           child: ListView.builder(
//             itemCount: topics.length,
//             itemBuilder: (context, index) {
//               return noteTile(
//                 topics[index].topicName,
//                 index,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Container noteTile(String topicName, int idx) {
//             final TeacherClassroomRepository controller =
//         Get.find<TeacherClassroomRepository>();
//     return Container(
//       height: 130.h,
//       margin: EdgeInsets.only(bottom: 16.h),
//       padding: EdgeInsets.all(10.w),
//       decoration: kDefaultDecoration,
//       child: Row(
//         children: [
//           Container(
//             width: 106.w,
//             margin: EdgeInsets.only(right: 10.w),
//             child: Image.asset(AssetsConstants.bulb),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 // Header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         topicName,
//                         style: kDark_14_600,
//                       ),
//                     ),
//                     Text(
//                       "Note ${idx + 1}",
//                       style: kDark_8_400.copyWith(
//                           fontSize: 8.sp, color: AppColors.tertiaryTextColor),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 30.h),
//                   ),
//                   onPressed: () {
//                     Get.to(() => PdfViewScreen(
//                       title: 'Notes',
//                       className: controller.selectedClass!.className,
//                       subjectName: controller.selectedSubject!.subjectName, 
//                       chapterName: chapterName,
//                       topics: topicName,
//                     ));
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Text(
//                         "View Notes",
//                         style: kLight_10_400,
//                       ),
//                       const Spacer(),
//                       Icon(
//                         CupertinoIcons.chevron_right,
//                         size: 10.w,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }