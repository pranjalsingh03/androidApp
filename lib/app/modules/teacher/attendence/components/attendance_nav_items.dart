import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/theme/app_colors.dart';

final List<BottomNavItemModel> attendanceBottomNavItems = [
  BottomNavItemModel(
    assetPath: Assets.navSheshya,
    color: AppColors.primaryColor,
    selectedColor: AppColors.primaryColor,
    name: 'Sheshya',
    index: 0,
  ),
  BottomNavItemModel(
    assetPath: Assets.attendanceNav,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Attendance',
    index: 1,
  ),
  BottomNavItemModel(
    assetPath: Assets.leaveNav,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Leave',
    index: 2,
  ),
  BottomNavItemModel(
    assetPath: Assets.reportNav,
    color: AppColors.iconColor,
    selectedColor: AppColors.textColor,
    name: 'Report',
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
