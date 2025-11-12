import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final Color bgcolor;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.press,
    this.bgcolor = AppColors.primaryColor,
  });
  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding =
        const EdgeInsets.symmetric(vertical: Dimensions.defaultPadding);
    return SizedBox(
      width: double.infinity,
      child: Platform.isIOS
          ? CupertinoButton(
              padding: verticalPadding,
              onPressed: press,
              child: buildText(context),
            )
          : MaterialButton(
              height: 48,
              color: bgcolor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: press,
              child: buildText(context),
            ),
    );
  }

  Text buildText(BuildContext context) {
    return Text(
      text,
      style: kLight_16_400,
      textAlign: TextAlign.center,
    );
  }
}
