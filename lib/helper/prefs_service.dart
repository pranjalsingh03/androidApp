import 'package:get_storage/get_storage.dart';
import 'package:sheshya/constants/pref_constants.dart';

class PrefsService {
  static final box = GetStorage();

  static bool saveTokenAndUserType(
      {required String token, required String userType}) {
    try {
      box.write(PrefConstants.userType, userType);
      box.write(PrefConstants.token, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String? getToken() {
    return box.read(PrefConstants.token);
  }

  static String? getUserType() {
    return box.read(PrefConstants.userType);
  }

  static void clearAll() {
    box.erase();
  }
}
