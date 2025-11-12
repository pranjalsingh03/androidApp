import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/theme/app_colors.dart';

final List<BottomNavItemModel> teacherClassManagementNavItems = [
  BottomNavItemModel(
    assetPath: Assets.navSheshya,
    color: AppColors.primaryColor,
    selectedColor: AppColors.primaryColor,
    name: 'Sheshya',
    index: 0,
  ),
  BottomNavItemModel(
    assetPath: Assets.navExam,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Management',
    index: 1,
  ),
  BottomNavItemModel(
    assetPath: Assets.navClassroom,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Academics',
    index: 2,
  ),
  BottomNavItemModel(
    assetPath: Assets.navChat,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Achievement',
    index: 3,
  ),
  BottomNavItemModel(
    assetPath: Assets.navProfile,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Profile',
    index: 4,
  ),
];
