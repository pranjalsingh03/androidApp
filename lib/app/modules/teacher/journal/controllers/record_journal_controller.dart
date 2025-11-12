import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class JournalController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var schedule = [].obs;
  var isLoading = true.obs;

  ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    super.onInit();
    fetchSchedule(); // Fetch schedule for the current date by default
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    fetchSchedule(date: date);
  }

  Future<void> fetchSchedule({DateTime? date}) async {
    isLoading.value = true;
    try {
      DateTime fetchDate = date ?? selectedDate.value;
      String dayName = DateFormat('EEEE').format(fetchDate); // Get the day name
      String formattedDate = DateFormat('MM-dd-yyyy').format(fetchDate); // Format the date
      final res = await apiClient.post(ApiConstants.teacherGetScheduleByDate, baseUrl: ApiConstants.apiBaseUrlNew, {
        "date": formattedDate, 
      });
      if (res.isOk) {
        schedule.value = res.body["data"];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateRecord({
    required String sclassName,
    required String subject,
    required String description,
    required String periodId,
  }) async {
    try {
      final res = await apiClient.post(ApiConstants.teacherUpdateRecord, baseUrl: ApiConstants.apiBaseUrlNew, {
        "sclassName": sclassName,
        "subject": subject,
        "description": description,
        "periodId": periodId,
      });
      if (res.isOk) {
        isLoading.value = false;
        fetchSchedule(); // Fetch updated schedule after updating the record
      }
    } catch (e) {
      print(e);
    }
  }
}