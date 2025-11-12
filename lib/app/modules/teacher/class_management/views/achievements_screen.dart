// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sheshya/app/modules/teacher/class_management/models/achievements_data.dart';
// import 'package:sheshya/app/modules/teacher/class_management/views/components/add_achievement_dialog.dart';
// import 'package:sheshya/app/modules/teacher/class_management/views/components/student_detail_small_card.dart';
// import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
// import 'package:sheshya/components/app_bar_back_button.dart';
// import 'package:sheshya/constant.dart';
// import 'package:sheshya/constants/dimensions.dart';
// import 'package:sheshya/constants/ui_constants.dart';
// import 'package:sheshya/theme/app_colors.dart';

// class AchievementScreen extends StatefulWidget {
//   const AchievementScreen({super.key});

//   @override
//   State<AchievementScreen> createState() => _AchievementScreenState();
// }

// class _AchievementScreenState extends State<AchievementScreen> {
//   final ManagementController controller = Get.find<ManagementController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Achievements',
//           textScaler: TextScaler.noScaling,
//         ),
//         leading: const AppBarBackButton(),
//         actions: [
//           IconButton(
//             onPressed: () => _showAddAchievementDialog(context),
//             icon: const Icon(Icons.add_circle, color: AppColors.primaryColor),
//           ),
//         ],
//       ),
//       body: GetBuilder<ManagementController>(
//         builder: (_) => Column(
//           children: [
//             StudentDetailSmallCard(
//               imageUrl: controller.studentDetail?.imageUrl ?? "",
//               name: controller.studentDetail?.name ?? "",
//               subtitle:
//                   "${controller.studentDetail!.className} ${controller.studentDetail!.section} | Roll No: ${controller.studentDetail!.rollNum}",
//             ),
//             k16YGap,
//             CustomTabBar(
//               controller: controller.tabController,
//               tabs: const [
//                 Tab(text: 'Overall'),
//                 Tab(text: 'Sports'),
//                 Tab(text: 'Academic'),
//               ],
//             ),
//             k16YGap,
//             Expanded(
//               child: TabBarView(
//                 controller: controller.tabController,
//                 children: [
//                   _buildOverallList(),
//                   _buildSportsList(),
//                   _buildAcademicList(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOverallList() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
//       itemCount: AchievementsData.overallAchievements.length,
//       itemBuilder: (context, index) {
//         final achievement = AchievementsData.overallAchievements[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: Dimensions.defaultPadding),
//           elevation: 2,
//           child: ListTile(
//             leading: Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child:
//                   const Icon(Icons.emoji_events, color: AppColors.primaryColor),
//             ),
//             title: Text(
//               achievement['title'],
//               style: darksemibold14,
//               textScaler: TextScaler.noScaling,
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   achievement['subtitle'],
//                   style: darknormal12,
//                   textScaler: TextScaler.noScaling,
//                 ),
//                 Text(
//                   achievement['date'],
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                   ),
//                   textScaler: TextScaler.noScaling,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSportsList() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
//       itemCount: AchievementsData.sportsAchievements.length,
//       itemBuilder: (context, index) {
//         final achievement = AchievementsData.sportsAchievements[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: Dimensions.defaultPadding),
//           elevation: 2,
//           child: ListTile(
//             leading: Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.sports, color: AppColors.accentColor),
//             ),
//             title: Text(
//               achievement['title'],
//               style: darksemibold14,
//             ),
//             subtitle: Text(
//               achievement['subtitle'],
//               style: darknormal12,
//             ),
//             trailing: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(
//                 achievement['medal'],
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAcademicList() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
//       itemCount: AchievementsData.academicAchievements.length,
//       itemBuilder: (context, index) {
//         final achievement = AchievementsData.academicAchievements[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: Dimensions.defaultPadding),
//           elevation: 2,
//           child: ListTile(
//             leading: Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.school, color: Colors.blue),
//             ),
//             title: Text(
//               achievement['title'],
//               style: darksemibold14,
//               textScaler: TextScaler.noScaling,
//             ),
//             subtitle: Text(
//               achievement['subtitle'],
//               style: darknormal12,
//               textScaler: TextScaler.noScaling,
//             ),
//             trailing: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryColor,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(
//                 achievement['grade'],
//                 style: const TextStyle(color: Colors.white),
//                 textScaler: TextScaler.noScaling,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showAddAchievementDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AddAchievementDialog(controller: controller);
//       },
//     );
//   }
// }

// class CustomTabBar extends StatelessWidget {
//   final TabController controller;
//   final List<Tab> tabs;

//   const CustomTabBar({
//     required this.controller,
//     required this.tabs,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: TabBar(
//         dividerHeight: 0,
//         overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//         tabAlignment: TabAlignment.fill,
//         controller: controller,
//         tabs: tabs,
//         indicator: BoxDecoration(
//           color: AppColors.primaryColor,
//           borderRadius: BorderRadius.circular(9),
//         ),
//         labelColor: Colors.white,
//         indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
//       ),
//     );
//   }
// }
