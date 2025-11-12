import 'package:flutter/material.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/app/data/model/ui_models/exam_type_model.dart';
import 'package:sheshya/theme/app_colors.dart';

List<ExamTypeModel> examData = [
  ExamTypeModel(
    title: "Olympiads",
    count: "32",
    tileImage: AssetsConstants.olympiad,
    activeColor: AppColors.primaryColor,
    bgImage: AssetsConstants.olympiadsBg,
  ),
  ExamTypeModel(
    title: "Scholarships",
    count: "32",
    tileImage: AssetsConstants.scholarship,
    activeColor: const Color(0xFFFFAF72),
    bgImage: AssetsConstants.scholarshipsBg,
  ),
  ExamTypeModel(
    title: "Competitive",
    count: "32",
    tileImage: AssetsConstants.competitive,
    activeColor: const Color(0xFF2EE279),
    bgImage: AssetsConstants.competitiveExamsBg,
  ),
];
