import 'package:flutter/services.dart';
import 'package:sheshya/theme/app_colors.dart';

class SystemUi {
  static SystemUiOverlayStyle defaultStyle =
      SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.backgroundColor,
    statusBarIconBrightness: Brightness.dark,
  );
}
