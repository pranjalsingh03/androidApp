import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> init() async {
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();
  // await WakelockPlus.enable();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
