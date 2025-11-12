import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';

class StudentCountCard extends StatelessWidget {
  const StudentCountCard(
      {super.key, required this.text, required this.bgcolor, this.num = '_ _'});
  final String text;
  final String num;
  final Color bgcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: bgcolor, borderRadius: BorderRadius.circular(2)),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.defaultPadding,
          vertical: Dimensions.defaultPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            num,
            style: darksemibold16.copyWith(fontSize: 24),
          ),
          Text(
            text,
            style: darknormal12,
            maxLines: 2,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            textScaler: TextScaler.noScaling,
          ),
        ],
      ),
    );
  }
}
