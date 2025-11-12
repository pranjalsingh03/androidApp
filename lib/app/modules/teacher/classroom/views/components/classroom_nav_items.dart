import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/theme/app_colors.dart';

final List<BottomNavItemModel> classroomBottomNavItems = [
  BottomNavItemModel(
    assetPath: Assets.navBack,
    color: AppColors.primaryColor,
    selectedColor: AppColors.primaryColor,
    name: 'Sheshya',
    index: 0,
  ),
  BottomNavItemModel(
    assetPath: Assets.navClassroom,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Classroom',
    index: 1,
  ),
  BottomNavItemModel(
    assetPath: Assets.navResult,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Result',
    index: 2,
  ),
  BottomNavItemModel(
    assetPath: Assets.navDoubt,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Doubt',
    index: 3,
  ),
  BottomNavItemModel(
    assetPath: Assets.navNotes,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Notes',
    index: 4,
  ),
];
