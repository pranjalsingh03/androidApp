import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';

class MyClassesCard extends StatelessWidget {
  final String className;
  final String sectionName;
  const MyClassesCard(
      {super.key, required this.className, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.defaultPadding,
          vertical: Dimensions.defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                className,
                style: darksemibold16.copyWith(fontSize: 18),
                textScaler: TextScaler.noScaling,
              ),
              Text(
                sectionName,
                style: darknormal12,
                textScaler: TextScaler.noScaling,
              ),
            ],
          )),
          const SizedBox(
            // width: 3,
            height: 47,
            child: VerticalDivider(
              width: 5,
              indent: 8,
              endIndent: 8,
              color: Color(0xFFD9D9D9),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                className,
                style: darksemibold16.copyWith(fontSize: 18),
                textScaler: TextScaler.noScaling,
              ),
              Text(
                sectionName,
                style: darknormal12,
                textScaler: TextScaler.noScaling,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
