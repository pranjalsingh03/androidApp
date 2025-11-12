import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/app/modules/teacher/teacher_input/views/teacher_screen.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  String? selectedClass;
  String? selectedSection;
  List<dynamic> classes = [];
  List<dynamic> sections = [];
  PageController classPageController = PageController(viewportFraction: 0.2);
  PageController sectionPageController = PageController(viewportFraction: 0.2);

  String? loadingMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClassesAndSections();
    });
  }

  Future<void> fetchClassesAndSections() async {
    setState(() {
      loadingMessage = "Loading classes and sections...";
    });
    try {
      final response = await ApiClient().post(
        ApiConstants.getSclasses,
        {},
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            classes = response.body['data'];
          });
        }
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load classes and sections");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      if (mounted) {
        setState(() {
          loadingMessage = null;
        });
      }
    }
  }

  Future<void> assignClassTeacher() async {
    setState(() {
      loadingMessage = "Assigning class teacher...";
    });
    try {
      final response = await ApiClient().put(
        ApiConstants.assignClassTeacher,
        {"classId": selectedSection},
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        showCustomSnackBar("Class teacher assigned successfully");
        Get.to(() => const ScheduleScreen());
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to assign class teacher");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      if (mounted) {
        setState(() {
          loadingMessage = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loadingMessage != null ? Colors.white : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const AppBarBackButton(),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => const ScheduleScreen());
            },
            child: const Text("Skip", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Your Class.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Choose your class & section to proceed.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: PageView.builder(
                                controller: classPageController,
                                itemCount: classes.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    selectedClass = classes[index]['id'];
                                    sections = classes[index]['sectionList'];
                                    selectedSection = null;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  var classData = classes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedClass = classData['id'];
                                        sections = classData['sectionList'];
                                        selectedSection = null;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      child: Text(
                                        classData['className'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: selectedClass == classData['id'] ? Colors.black : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: PageView.builder(
                                controller: sectionPageController,
                                itemCount: sections.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    selectedSection = sections[index]['id'];
                                  });
                                },
                                itemBuilder: (context, index) {
                                  var sectionData = sections[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (selectedClass != null) {
                                        setState(() {
                                          selectedSection = sectionData['id'];
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                      child: Text(
                                        sectionData['sectionName'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: selectedSection == sectionData['id'] ? Colors.black : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedClass != null && selectedSection != null
                        ? () {
                            assignClassTeacher();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (loadingMessage != null)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Loader(),
                    const SizedBox(height: 20),
                    Text(
                      loadingMessage!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}