import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/auth/controllers/auth_controller.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/helper/prefs_service.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model Class
class LeaveRecord {
  final int present;
  final int leaves;
  final int workingDays;

  LeaveRecord({
    required this.present,
    required this.leaves,
    required this.workingDays,
  });

  factory LeaveRecord.fromJson(Map<String, dynamic> json) {
    return LeaveRecord(
      present: json['present'] ?? 0,
      leaves: json['leaves'] ?? 0,
      workingDays: json['workingDays'] ?? 0,
    );
  }
}

// Controller Class
class LeaveRecordsController extends GetxController {
  var isLoading = true.obs;
  var leaveRecord = LeaveRecord(present: 0, leaves: 0, workingDays: 0).obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveRecord();
  }

  Future<void> fetchLeaveRecord() async {
    try {
      final token = PrefsService.getToken();

      final response = await http.get(
        Uri.parse('https://sheshya-backend-deployed-529940359558.asia-south1.run.app/teacher/getLeaveRecord'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        leaveRecord.value = LeaveRecord.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('Failed to load leave record');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load leave record');
    } finally {
      isLoading.value = false;
    }
  }
}

// View Class
class LeaveRecordsScreen extends StatelessWidget {
  final LeaveRecordsController controller = Get.put(LeaveRecordsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Records'),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: Loader(text: "Loading Leave Records",));
        } else {
          final data = controller.leaveRecord.value;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoCard('Present', data.present.toString()),
                    _buildInfoCard('On Leave', data.leaves.toString()),
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.secondaryColor, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance Record',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildAttendanceData('Working Days', data.workingDays, Colors.blue),
                        _buildAttendanceData('Present', data.present, Colors.blue),
                        _buildAttendanceData('On Leave', data.leaves, Colors.orange),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Back to Homepage',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: 220,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.secondaryColor, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceData(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: color,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}