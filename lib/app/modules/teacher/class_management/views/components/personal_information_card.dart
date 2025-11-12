import 'package:flutter/material.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/table_row_text.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class PersonalInformationCard extends StatelessWidget {
  const PersonalInformationCard({super.key});

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
                'Personal Information',
                style: darksemibold14,
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.defaultPadding,
          ),
          TableRowText(
            cat: 'Gender',
            value: 'Female',
          ),
          Divider(
            color: AppColors.secondaryTextColor,
          ),
          TableRowText(
            cat: 'Contact',
            value: '6257xxxxxx',
          ),
          Divider(
            color: AppColors.secondaryTextColor,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
            child: Row(
              children: [
                Text(
                  'Address |',
                  style: darknormal12,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Narendra Pur,Sector 21,New Delhi 110051,india',
                      style: darksemibold12,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
