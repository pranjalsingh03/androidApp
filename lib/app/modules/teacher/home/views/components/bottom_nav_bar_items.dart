import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/theme/app_colors.dart';

final List<BottomNavItemModel> teacherHomeBottomNavItems = [
  BottomNavItemModel(
    assetPath: Assets.navSheshya,
    color: AppColors.primaryColor,
    selectedColor: AppColors.primaryColor,
    name: 'Sheshya',
    index: 0,
  ),
  BottomNavItemModel(
    assetPath: Assets.navExam,
    color: AppColors.unSelectedItemColor,
    selectedColor: AppColors.textColor,
    name: 'Exam',
    index: 1,
  ),
  BottomNavItemModel(
    assetPath: Assets.navClassroom,
    color: AppColors.unSelectedItemColor,
    selectedColor: AppColors.textColor,
    name: 'Classroom',
    index: 2,
  ),
  BottomNavItemModel(
    assetPath: Assets.navChat,
    color: AppColors.unSelectedItemColor,
    selectedColor: AppColors.textColor,
    name: 'Chatbox',
    index: 3,
  ),
  BottomNavItemModel(
    assetPath: Assets.navProfile,
    color: AppColors.unSelectedItemColor,
    selectedColor: AppColors.textColor,
    name: 'Profile',
    index: 4,
  ),
];
