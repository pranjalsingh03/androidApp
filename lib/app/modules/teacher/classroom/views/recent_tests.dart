import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/select_assignment.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class RecentTests extends StatelessWidget {
  const RecentTests({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTeachingClasses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: Loader(text: "Loading Classes")),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('No Results Found')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No classes available')),
          );
        } else {
          final classResultList = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              leading: const AppBarBackButton(),
              title: const Text("Results"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(Dimensions.defaultPadding),
              child: ListView(
                children: [
                  k20YGap,
                  Text("See the result of your class", style: kDark_16_500),
                  k8YGap,
                  ...classResultList.map((e) => GestureDetector(
                        onTap: () => Get.to(() => SelectAssignment(sclassId: e['sclassId'])),
                        child: Container(
                          decoration: kDefaultDecorationBordered,
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  e['className'],
                                  style: kLight_12_500.copyWith(color: Colors.white),
                                ),
                              ),
                              k8XGap,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Class ${e['className']}",
                                      style: kDark_14_600,
                                    ),
                                    Text(
                                      "Sec - ${e['sclassName']}",
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
                      )),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchTeachingClasses() async {
    final apiClient = ApiClient();
    final response = await apiClient.get(
      '/teacher/getTeachingSclasses',
      passToken: true,
      baseUrl: ApiConstants.apiBaseUrlNew,
    );

    if (response.statusCode == 200) {
      final data = response.body['data'] as List;
      return data.map((item) {
        return {
          'sclassId': item['sclassId'],
          'className': item['className'],
          'sclassName': item['sclassName'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load classes');
    }
  }
}