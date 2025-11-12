import 'package:flutter/material.dart';

class ExamTypeModel {
  final String title;
  final String count;
  final String tileImage;
  final String bgImage;
  final Color activeColor;

  ExamTypeModel({
    required this.title,
    required this.count,
    required this.tileImage,
    required this.bgImage,
    required this.activeColor,
  });
}
