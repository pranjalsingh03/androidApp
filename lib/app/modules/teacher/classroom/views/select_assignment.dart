import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/results_view.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class SelectAssignment extends StatelessWidget {
  final String sclassId;

  const SelectAssignment({required this.sclassId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAssignments(sclassId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: Loader(text: "Loading Assignments")),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('No Assignment Found')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No assignments available')),
          );
        } else {
          final assignmentList = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: const AppBarBackButton(),
              title: const Text("Select Assignment"),
          ),
            body: Padding(
              padding: const EdgeInsets.all(Dimensions.defaultPadding),
              child: ListView.builder(
                itemCount: assignmentList.length,
                itemBuilder: (context, index) {
                  final assignment = assignmentList[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ResultsView(sclassId: sclassId, assignmentId: assignment['_id'])),
                    child: Container(
                      decoration: kDefaultDecorationBordered,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: Row(
                        children: [
                          k8XGap,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assignment['assignmentName'],
                                  style: kDark_14_600,
                                ),
                                Text(
                                  "Topic: ${assignment['topic']}",
                                  style: kSecondary_10_400,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchAssignments(String sclassId) async {
    final apiClient = ApiClient();
    final response = await apiClient.post(
      '/teacher/getAllTestsOfAClassByTeacher',
      {'sclassId': sclassId},
      passToken: true,
      baseUrl: ApiConstants.apiBaseUrlNew,
    );

    if (response.statusCode == 200) {
      final data = response.body['data'] as List;
      return data.map((item) {
        return {
          '_id': item['_id'],
          'assignmentName': item['assignmentName'],
          'topic': item['topic'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }
}