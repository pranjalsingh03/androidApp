import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class ScheduleController extends GetxController {
  ApiClient apiClient = ApiClient();
  RxList<Map<String, String>> periods = <Map<String, String>>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedDay = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDay.value = DateFormat('EEEE').format(DateTime.now());
    fetchSchedule(selectedDay.value);
  }

void fetchSchedule(String day) async {
  isLoading.value = true;
  try {
    var res = await apiClient.post('/student/getTodaySchedule', {
      "day": day,
    }, passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);
    print("Response Status Code: ${res.statusCode}");
    
    // Step 1: Determine the type of res.body and handle accordingly
    dynamic responseData;
    if (res.body is String) {
      try {
        print("Response Body is String: ${res.body}");
        responseData = jsonDecode(res.body);
      } catch (e) {
        print("JSON decode error: $e");
        throw Exception("Invalid response format");
      }
    } else if (res.body is Map) {
      print("Response Body is already a Map");
      responseData = res.body;
    } else {
      print("Response Body is unknown type: ${res.body.runtimeType}");
      throw Exception("Unknown response type: ${res.body.runtimeType}");
    }
    
    if (res.statusCode == 200) {
      // Step 2: Log the type and content for debugging
      print("Response Data Type: ${responseData.runtimeType}");
      print("Response Data: $responseData");
      
      // Step 3: Access data safely
      if (responseData['data'] is List) {
        periods.value = (responseData['data'] as List).map((item) {
          // Safely convert each field, handling potential null values
          return {
            'periodId': item['periodId']?.toString() ?? '',
            'subject': item['subject']?.toString() ?? '',
            'teacher': item['teacher']?.toString() ?? '',
          };
        }).toList();
        
        print("Successfully parsed schedule: ${periods.value}");
      } else {
        print("Data field is not a List: ${responseData['data']?.runtimeType}");
        showCustomSnackBar("Invalid data format!");
      }
    } else {
      print("Error: Received status code ${res.statusCode}");
      showCustomSnackBar("Failed to fetch schedule!");
    }
  } catch (e) {
    print("Exception in fetchSchedule: $e");
    showCustomSnackBar("Something went wrong!");
  } finally {
    isLoading.value = false;
  }
}



  void updateSelectedDay(String day) {
    selectedDay.value = day;
    fetchSchedule(day);
  }
}

class SchedulePage extends StatelessWidget {
  final ScheduleController controller = Get.put(ScheduleController());

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final List<String> weekDaysShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Schedule"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Day selector
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weekDays.length,
                  itemBuilder: (context, index) {
                    bool isSelected = weekDays[index] == controller.selectedDay.value;
                    return GestureDetector(
                      onTap: () {
                        controller.updateSelectedDay(weekDays[index]);
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFF7F50) : const Color(0xFFE8EAF0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weekDaysShort[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Schedule list
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: Loader(text: "Getting your schedule..."));
                  } else if (controller.periods.isEmpty) {
                    return const Center(child: Text("No schedule available"));
                  } else {
                    return ListView.builder(
                      itemCount: controller.periods.length,
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xffEAEAEA)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.periods[index]['subject']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.periods[index]['periodId']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.periods[index]['teacher']!,
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}