import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/student_details_view.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class ResultsView extends StatefulWidget {
  final String sclassId;
  final String assignmentId;

  const ResultsView(
      {required this.sclassId, required this.assignmentId, super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, dynamic>> _resultsFuture;
  late Future<List<String>> _weaknessFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _resultsFuture = fetchResults(widget.sclassId, widget.assignmentId);
    _weaknessFuture = fetchWeakness(widget.sclassId, widget.assignmentId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Results"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Class'),
            Tab(text: 'Students'),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _resultsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: Loader(text: "Loading Result")),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('No Result available')),
            );
          } else if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: Text('No Result available')),
            );
          } else {
            final results = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  classView(results),
                  studentView(results['studentData']),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget studentView(List<dynamic> studentData) {
    return ListView(
      children: [
        kdefaultYGap,
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
          child: Text(
            "Top Performing Students",
            style: kDark_16_500,
          ),
        ),
        k16YGap,
        allStudents(studentData),
        k20YGap,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            "All Students Results",
            style: kDark_16_500,
          ),
        ),
        k16YGap,
        ...studentData.map((e) => studentTile(
            name: e['name'],
            image: e['image'],
            marks: e['marks'].toString(),
            studentId: e['_id'])),
      ],
    );
  }

  Widget studentTile(
      {required String name,
      required String marks,
      required String studentId, required image}) {
    return GestureDetector(
      onTap: () => Get.to(() => StudentDetailsView(
          studentId: studentId,
          assignmentId: widget.assignmentId,
          studentName: name)),
      child: Container(
        decoration: kDefaultDecorationBordered,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.all(8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(image),
            ),
            k8XGap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kDark_16_600,
                ),
                Text("$marks Marks", style: kSecondary_12_400),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(
              Assets.arrowRight,
            ),
          ],
        ),
      ),
    );
  }

  Widget classView(Map<String, dynamic> results) {
    return FutureBuilder<List<String>>(
      future: _weaknessFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Loader(text: "Loading Weaknesses"));
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No suggestions available'));
        } else {
          final weaknesses = snapshot.data!;
          return ListView(
            children: [
              kdefaultYGap,
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  "Class Performance Summary",
                  style: kDark_16_500,
                ),
              ),
              k16YGap,
              allStats(results),
              k20YGap,
              recordTotal(results),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text("Weaknesses of Class", style: kDark_16_500),
              ),
              ...weaknesses.map((weakness) => _buildSuggestionCard(weakness)).toList(),
            ],
          );
        }
      },
    );
  }

  Widget _buildSuggestionCard(String text, {IconData? icon}) {
    return Card(
      shadowColor: Colors.transparent,
      borderOnForeground: true,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: Colors.blue) : null,
        title: Text(text, style: kDark_14_400),
      ),
    );
  }

  Padding allStudents(List<dynamic> studentData) {
    final topStudents = studentData.take(3).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: topStudents.map((e) {
          return Expanded(
            child: resultStatsCard(
                title: "${e['marks']} Marks", subtitle: e['name']),
          );
        }).toList(),
      ),
    );
  }

  Padding recordTotal(Map<String, dynamic> results) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: recordTotalStats(results),
    );
  }

  Padding allStats(Map<String, dynamic> results) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildScoreCard("Highest", "${results['highest']}", Colors.blue),
          _buildScoreCard("Lowest", "${results['lowest']}", Colors.grey),
          _buildScoreCard(
              "Average", "${results['average']}", Colors.red.shade300),
        ],
      ),
    );
  }

  Widget _buildScoreCard(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(width: 0.5, color: Colors.grey.shade300),
          ),
          child: SizedBox(
            height: 30,
            width: 75,
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container resultStatsCard({required String title, required String subtitle}) {
    return Container(
      height: 124.h,
      padding: const EdgeInsets.all(16),
      decoration: kDefaultDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(Assets.schoolBuilding),
          Text(title, style: kDark_12_600),
          Text(subtitle, style: kSecondary_12_400),
        ],
      ),
    );
  }

  Container pieChart(Map<String, dynamic> results) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 28),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(AssetsConstants.pieChart),
                Column(
                  children: [
                    Text(
                      results['average'].toString(),
                      style: UiConstants.dark_10_700.copyWith(fontSize: 30),
                    ),
                    const Text(
                      "Average range",
                      style: UiConstants.dark_12_400,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          recordTotalStats(results)
        ],
      ),
    );
  }

  Row recordCardTitle({
    required Color bgColor,
    required String text,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 7,
          backgroundColor: bgColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: kDark_12_600,
          ),
        ),
        Text(
          value,
          style: kSecondary_12_500,
        )
      ],
    );
  }

  Row recordTileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Statistics",
              style: kDark_10_500,
            ),
            k4YGap,
            Text(
              "Exam 1",
              style: kDark_14_500,
            )
          ],
        ),
        SvgPicture.asset(Assets.arrowRight),
      ],
    );
  }

  Column recordTotalStats(Map<String, dynamic> results) {
    return Column(
      children: [
        recordCardTitle(
            bgColor: AppColors.primaryColor,
            text: "Passed",
            value: results['passed'].toString()),
        recordCardTitle(
            bgColor: AppColors.primaryLowVersionColor,
            text: "Failed",
            value: results['failed'].toString()),
        recordCardTitle(
            bgColor: AppColors.accentColor,
            text: "Not Submitted",
            value: results['missed'].toString()),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchResults(
      String sclassId, String assignmentId) async {
    final apiClient = ApiClient();
    final response = await apiClient.post(
      '/teacher/getResultOfAClassInAssignment',
      {'sclassId': sclassId, 'assignmentId': assignmentId},
      passToken: true,
      baseUrl: ApiConstants.apiBaseUrlNew,
    );

    if (response.statusCode == 200) {
      return response.body['data'];
    } else {
      throw Exception('Failed to load results');
    }
  }

  Future<List<String>> fetchWeakness(String sclassId, String assignmentId) async {
    final apiClient = ApiClient();
    final response = await apiClient.post(
      '/teacher/getSclassWeakness',
      {'sclassId': sclassId, 'assignmentId': assignmentId},
      passToken: true,
      baseUrl: ApiConstants.apiBaseUrlNew,
    );

    if (response.statusCode == 200) {
      return List<String>.from(response.body['data']);
    } else {
      throw Exception('Failed to load weaknesses');
    }
  }
}