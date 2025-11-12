import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/helper/extensions_helper.dart';
import 'package:sheshya/theme/app_colors.dart';

class DifficultySelector extends StatelessWidget {
  final String currentDifficulty;
  final List<String> difficulties;
  final Function(String) onDifficultyChanged;

  const DifficultySelector({
    super.key,
    required this.currentDifficulty,
    required this.difficulties,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 11.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.strokeColor),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: currentDifficulty,
            elevation: 1,
            isExpanded: true,
            itemHeight: 50.h,
            menuMaxHeight: 300,
            dropdownColor: Colors.white,
            iconSize: 18.r,
            padding: EdgeInsets.only(right: 10.w),
            borderRadius:
                BorderRadius.circular(Dimensions.defaultRoundedCorner),
            selectedItemBuilder: (context) => difficulties
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.toCapitalized(),
                          style: kDark_14_500,
                        ),
                      ],
                    ))
                .toList(),
            icon: const Icon(
              CupertinoIcons.chevron_down,
              color: AppColors.primaryColor,
            ),
            items: difficulties
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toCapitalized(),
                        style: kDark_14_500,
                      ),
                    ))
                .toList(),
            onChanged: (value) => onDifficultyChanged(value!),
          ),
        ),
      ),
    );
  }
}
