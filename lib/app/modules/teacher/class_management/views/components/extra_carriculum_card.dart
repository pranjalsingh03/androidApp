import 'package:flutter/material.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/table_row_text.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class ExtraCarriculumCard extends StatelessWidget {
  const ExtraCarriculumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 8, right: 8, top: 8, bottom: Dimensions.defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                color: AppColors.primaryColor,
                size: Dimensions.defaultPadding,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                'Extra Curriculum ',
                style: darksemibold14,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.defaultPadding,
          ),
          TableRowText(
            cat: 'Sport',
            value: 'Batminton',
          ),
          Divider(
            color: AppColors.secondaryTextColor,
          ),
          TableRowText(
            cat: 'Arts',
            value: 'Drawing',
          ),
          Divider(
            color: AppColors.secondaryTextColor,
          ),
          TableRowText(
            cat: 'Musin',
            value: 'Piano',
          ),
        ],
      ),
    );
  }
}
