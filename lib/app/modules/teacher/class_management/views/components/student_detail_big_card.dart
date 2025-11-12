import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentDetailBigCard extends StatelessWidget {
  const StudentDetailBigCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
          right: 8, top: 8, left: 8, bottom: Dimensions.defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: Dimensions.defaultPadding,
              ),
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.secondaryTextColor,
                ),
              ),
              Text(
                'Student name',
                style: darksemibold16.copyWith(fontSize: 24),
              ),
              const Text(
                'ADHAR ID - XXXXXXX',
                style: darksemibold10,
              ),
              const Text(
                '9th A',
                style: darksemibold10,
              )
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              // height: 20,
              child: Chip(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  side: BorderSide.none,
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  label: const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 10,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FittedBox(
                        child: Text(
                          '4.33',
                          style: whitenormal10,
                        ),
                      )
                    ],
                  )),
            ),
          ),
          const Positioned(
              top: 8,
              left: 0,
              child: Text(
                'Roll No. | 05 ',
                style: darknormal12,
              )),
        ],
      ),
    );
  }
}
