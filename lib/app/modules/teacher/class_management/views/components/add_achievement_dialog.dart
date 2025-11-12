// import 'package:flutter/material.dart';
// import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
// import 'package:sheshya/constant.dart';
// import 'package:sheshya/constants/dimensions.dart';
// import 'package:sheshya/theme/app_colors.dart';

// class AddAchievementDialog extends StatelessWidget {
//   const AddAchievementDialog({super.key, required this.controller});
//   final ManagementController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner)),
//       child: Container(
//         height: 255, // Increased height to accommodate the form
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(5)),
//         child: Form(
//           key: controller.achievementFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: Dimensions.defaultPadding,
//                     vertical: Dimensions.defaultPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Icon(
//                           Icons.arrow_back_ios,
//                           color: AppColors.bodyTextColor,
//                           size: Dimensions.defaultPadding,
//                         ),
//                         SizedBox(
//                           width: Dimensions.defaultPadding * 2,
//                         ),
//                         Text(
//                           'Add Achievement',
//                           style: darksemibold14,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       child: DropdownButtonFormField<String>(
//                         value: controller.selectedCategory.value,
//                         onChanged: (value) {
//                           controller.selectedCategory.value = value!;
//                         },
//                         items: const [
//                           DropdownMenuItem(
//                             value: 'Education',
//                             child: Text('Education'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'Sports',
//                             child: Text('Sports'),
//                           ),
//                         ],
//                         decoration: InputDecoration(
//                           fillColor: const Color(0xFFD9D9D9),
//                           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                           hintText: 'Category',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       height: 45,
//                       child: TextFormField(
//                         controller: controller.positionController,
//                         decoration: InputDecoration(
//                           fillColor: const Color(0xFFD9D9D9),
//                           labelText: 'Position',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the position';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     SizedBox(
//                       height: 45,
//                       child: TextFormField(
//                         controller: controller.competitionController,
//                         decoration: InputDecoration(
//                           fillColor: const Color(0xFFD9D9D9),
//                           labelText: 'Competition',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the competition';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.addAchievement();
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(5),
//                         bottomRight: Radius.circular(5),
//                       ),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     child: const Center(
//                       child: Text(
//                         'Add Achievement',
//                         style: whitesemibolde12,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
