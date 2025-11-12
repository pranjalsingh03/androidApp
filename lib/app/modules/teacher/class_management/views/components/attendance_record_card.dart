// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sheshya/constant.dart';
// import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';

// class AttendanceRecordCard extends StatelessWidget {
//   const AttendanceRecordCard({super.key, required this.controller});

//   final AttendanceController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.allDimensions.defaultPadding),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Column(
//                 children: [
//                   Text(
//                     'Attendance Record',
//                     style: darksemibold14,
//                     textScaler: TextScaler.noScaling,
//                   ),
//                   Text(
//                     '20th August - 26h August ',
//                     style: darksemibold10,
//                     textScaler: TextScaler.noScaling,
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: defaultPadding * 2,
//               ),
//               SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: Obx(() {
//                   return PieChart(
//                     PieChartData(
//                       pieTouchData: PieTouchData(),
//                       centerSpaceRadius: 50,
//                       sectionsSpace: 0,
//                       sections: [
//                         PieChartSectionData(
//                           color: bodyTextColor,
//                           value: controller.presentPercentage,
//                           title:
//                               '${controller.presentPercentage.toStringAsFixed(1)}%',
//                           radius: 50,
//                           titleStyle: whitesemibolde16.copyWith(fontSize: 20),
//                         ),
//                         PieChartSectionData(
//                           color: accentColor,
//                           value: controller.absentPercentage,
//                           title:
//                               '${controller.absentPercentage.toStringAsFixed(1)}%',
//                           radius: 50,
//                           titleStyle: whitesemibolde16.copyWith(fontSize: 20),
//                         ),
//                         PieChartSectionData(
//                           color: primaryColor,
//                           value: controller.leavePercentage,
//                           title:
//                               '${controller.leavePercentage.toStringAsFixed(1)}%',
//                           radius: 50,
//                           titleStyle: whitesemibolde16.copyWith(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//               const SizedBox(
//                 height: Dimensions.defaultPadding,
//               ),
//               const Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 23,
//                             child: VerticalDivider(
//                               width: 3,
//                               thickness: 3,
//                               color: bodyTextColor,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             '5 Days Present',
//                             style: darksemibold14,
//                             textScaler: TextScaler.noScaling,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 23,
//                             child: VerticalDivider(
//                               width: 3,
//                               thickness: 3,
//                               color: accentColor,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             ' 1 Days Absent',
//                             style: darksemibold14,
//                             textScaler: TextScaler.noScaling,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Dimensions.defaultPadding,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         height: 23,
//                         child: VerticalDivider(
//                           width: 3,
//                           thickness: 3,
//                           color: primaryColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Text(
//                         '1 Day Leave',
//                         style: darksemibold14,
//                         textScaler: TextScaler.noScaling,
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
