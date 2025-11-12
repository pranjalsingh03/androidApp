import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sheshya/app/modules/student/ai_classroom/ai_performance/ai_subject.dart';
import 'package:sheshya/app/modules/student/ai_classroom/get_test_of_subject.dart';
import 'package:sheshya/app/modules/student/notes/notes_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/helper/custom_print.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/pref_constants.dart';
import '../../../../constants/ui_constants_old.dart';
import '../../../../theme/app_colors.dart';
import 'notes/all_notes_subject.dart';

class AiClassroom extends StatefulWidget {
  const AiClassroom({super.key});

  @override
  State<AiClassroom> createState() => _AiClassroomState();
}

class _AiClassroomState extends State<AiClassroom> {
  late Future<List<Subject>> _subjectsFuture;

  @override
  void initState() {
    super.initState() ;
    _subjectsFuture = fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Classroom',
          style: TextStyle(
            color: Color(0xFF467BFA),
            fontSize: 28,
            fontFamily: 'Lufga',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true, // Optional: Center the title
        leading: const AppBarBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  children: [
                    Text("Your Digital Class",
                        style: UiConstants.secondary_18_400.copyWith(
                          fontSize: 20,
                        )),
                    const SizedBox(height: 50),
                    SvgPicture.asset(AssetsConstants.heroClassroom, height: 150),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Subjects',
                    style: TextStyle(
                      color: Color(0xFF374957),
                      fontSize: 16,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<Subject>>(
                    future: _subjectsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Loader(text: "Getting subjects",));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final subjects = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                          child: Row(
                            children: subjects.map((subject) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: _buildSubjectCard(
                                  subject.image,
                                  subject.subjectName,
                                    subject.id
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        return Text('No subjects available');
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'See the Results and Notes',
                    style: TextStyle(
                      color: Color(0xFF374957),
                      fontSize: 16,
                      fontFamily: 'Lufga',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>const AiResults());
                      },
                      child: Container(
                        height: 188,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFEAEAEA)),
                              borderRadius: BorderRadius.circular(5)),
                          // shadows: const [
                          //   BoxShadow(
                          //     color: Color(0x0C000000),
                          //     blurRadius: 15,
                          //     offset: Offset(0, 2),
                          //     spreadRadius: 5,
                          //   )
                          // ],
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: SvgPicture.asset(AssetsConstants.aiResultClassroom)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "AI Results",
                                  style: UiConstants.dark_14_600,
                                ),
                                SvgPicture.asset(Assets.arrowRight),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>NotesScreen());
                      },
                      child: Container(
                        height: 188,
                        width: (Get.width - 32 - 19) / 2,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFFEAEAEA), width: 1),
                              borderRadius: BorderRadius.circular(5)),
                              
                          // shadows: const [
                          //   BoxShadow(
                          //     color: Color(0x0C000000),
                          //     blurRadius: 15,
                          //     offset: Offset(0, 2),
                          //     spreadRadius: 5,
                          //   )
                          // ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: SvgPicture.asset(AssetsConstants.discipline),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Notes",
                                  style: TextStyle(
                                    color: AppColors.bodyTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SvgPicture.asset(Assets.arrowRight),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     GestureDetector(
                  //       onTap:(){
                  //         Get.to(()=>const AiResults());
                  //       },
                  //       child: _buildResultCard(
                  //           "AI Results", AssetsConstants.aiResultClassroom),
                  //     ), // Replace with AI Results image URL
                  //     SizedBox(width: 10,),
                  //     GestureDetector(
                  //       onTap: (){
                  //         Get.to(()=>AllNotesSubject());
                  //       },
                  //       child: _buildResultCard(
                  //           "Notes", AssetsConstants.aiNotesClassroom),
                  //     ), // Replace with Notes image URL
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(String image, String label,String id) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>GetTestOfSubject(subjectId: id,name: label,));
      },
      child: Column(
        children: [
          Container(
            width: 92,
            height: 87,
            decoration: ShapeDecoration(
              color: Colors.white,
              image: DecorationImage(image: NetworkImage(image)),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE9E9E9)),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF374957),
              fontSize: 12,
              fontFamily: 'Lufga',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, String imageUrl) {
    return Expanded(
      child:Container(
        width: 156,
        height: 166,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFE9E9E9)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(alignment: Alignment.centerRight,child: SvgPicture.asset(imageUrl, height: 100)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF374957),
                    fontSize: 14,
                    fontFamily: 'Lufga',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xff374957),
              )
            ],
            )
          ],
        ),
      )
    );
  }
}

class Subject {
  final String id;
  final String subjectName;
  final String image;

  Subject({required this.id, required this.subjectName,required this.image});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      subjectName: json['subjectName'],
      image: json['imageUrl']??'https://img.freepik.com/free-vector/illustration-notebook-icon_53876-5858.jpg'
    );
  }
}

Future<List<Subject>> fetchSubjects() async {
  const url = 'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/getSubjects';
  final token = GetStorage().read(PrefConstants.token);
  final response = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    customPrint('Subjects: $data');
    return data.map((json) => Subject.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch subjects');
  }
}