import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/get_leaves_records_res_model.dart';
import 'package:sheshya/components/app_bar_back_button.dart';

class LeaveAttendanceRecordsScreen extends StatelessWidget {
  final List<Data>? data;

  const LeaveAttendanceRecordsScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    // Sort the data by date in ascending order
    List<Data>? sortedData = data;
    sortedData?.sort((a, b) {
      DateTime dateA = DateTime.parse(a.date ?? '');
      DateTime dateB = DateTime.parse(b.date ?? '');
      return dateB.compareTo(dateA); // Sort in descending order
    });

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text(
          "Leave Records",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: sortedData == null || sortedData.isEmpty
          ? Center(child: Text("No leave records available"))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: sortedData.length,
              itemBuilder: (context, index) {
                final leave = sortedData[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  color: const Color(0xffFFFFFF),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Color(0xffEAEAEA), width: 0.7)),
                  elevation: 0,
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: const Color(0xff374957),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: "${formatDateString(leave.date ?? '')} | ",
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xff838A8F),
                                    fontFamily: 'Lufga')),
                            TextSpan(
                                text: "Approved",
                                style: TextStyle(
                                    fontFamily: 'Lufga',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: const Color(0xff2FFF00))),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                leave.reason ?? "No reason provided",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String formatDateString(String isoDateString) {
    try {
      DateTime dateTime = DateTime.parse(isoDateString).toLocal();
      return DateFormat('d\'th\' MMMM, yyyy').format(dateTime);
    } catch (e) {
      return "Invalid date format"; // Or handle the error as needed
    }
  }
}