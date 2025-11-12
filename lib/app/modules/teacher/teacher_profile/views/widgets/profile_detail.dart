import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/styles.dart';

class ProfileDetail extends StatelessWidget {
  final String title;
  final String value;
  const ProfileDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: kDark_12_500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: kSecondary_12_400,
            ),
          ),
        ],
      ),
    );
  }
}
