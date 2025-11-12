import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_classroom_repo.dart';
import 'package:sheshya/app/routes/app_pages.dart';
import 'package:sheshya/constants/app_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/helper/di.dart';
import 'package:sheshya/helper/init.dart';
import 'package:sheshya/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TeacherClassroomRepository());

  await init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: UiConstants.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          // defaultTransition: Transition.native, // Apply fade transition globally
          // transitionDuration: Duration(milliseconds: 300),
          themeMode: ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          initialBinding: Di(),
          getPages: AppPages.routes,
          theme: AppTheme.lightTheme,
          builder: (context, child) {
            return SafeArea(  // Ensures content stays within visible bounds
              child: child ?? Container(),
            );
          },
        );
      },
    );
  }
}
