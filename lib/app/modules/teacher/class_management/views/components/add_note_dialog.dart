import 'package:flutter/material.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';

import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class AddNotDialog extends StatelessWidget {
  const AddNotDialog({
    super.key,
    required this.controller,
  });

  final ManagementController controller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 185,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultPadding,
                  vertical: Dimensions.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.bodyTextColor,
                        size: Dimensions.defaultPadding,
                      ),
                      SizedBox(
                        width: Dimensions.defaultPadding * 2,
                      ),
                      Text(
                        'Add a Note',
                        style: darksemibold14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    child: TextField(
                      controller: controller.parentMessageController,
                      decoration: const InputDecoration(
                          hintText: 'Note',
                          helperStyle: darknormal12,
                          border: OutlineInputBorder(),
                          fillColor: Color(0xFFD9D9D9)),
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        'Add Note',
                        style: whitesemibolde12,
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
