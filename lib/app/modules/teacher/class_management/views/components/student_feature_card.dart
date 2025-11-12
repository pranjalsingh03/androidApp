import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';

class StudentFeatureCard extends StatelessWidget {
  const StudentFeatureCard({
    super.key,
    required this.press,
    required this.text,
  });
  final GestureTapCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        height: 188,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Text(
                text,
                style: darknormal14,
                overflow: TextOverflow.clip,
                textScaler: TextScaler.noScaling,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
