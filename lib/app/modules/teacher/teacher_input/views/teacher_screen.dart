import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/theme/app_colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedDay = "Monday";
  String? selectedPeriod;
  String? selectedClass;
  String? selectedSection;
  String? selectedSubject;

  List<dynamic> periods = [];
  List<dynamic> classes = [];
  List<dynamic> sections = [];
  List<dynamic> subjects = [];
  PageController classPageController = PageController(viewportFraction: 0.2);
  PageController sectionPageController = PageController(viewportFraction: 0.2);

  String? loadingMessage;

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClassesAndSections();
    });
  }

  Future<void> fetchPeriods() async {
    try {
      final response = await ApiClient().get(
        ApiConstants.getPeriods,
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        setState(() {
          periods = response.body['data'];
        });
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load periods");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    }
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
        setState(() {
          classes = response.body['data'];
        });
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load classes and sections");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
          fetchPeriods();

      setState(() {
        loadingMessage = null;
      });
    }
  }

  Future<void> fetchSubjects(String sectionId) async {
    setState(() {
      loadingMessage = "Loading subjects...";
    });
    try {
      final response = await ApiClient().post(
        ApiConstants.getSubjectList,
        {"sectionId": sectionId},
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        setState(() {
          subjects = response.body['data'];
        });
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load subjects");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      setState(() {
        loadingMessage = null;
      });
    }
  }

  Future<void> addTeacherSchedule() async {
    setState(() {
      loadingMessage = "Saving schedule...";
    });
    try {
      final response = await ApiClient().post(
        ApiConstants.addTeacherSchedule,
        {
          "day": selectedDay,
          "periodId": selectedPeriod,
          "subjectId": selectedSubject,
          "sectionId": selectedSection,
          "isFree": "false"
        },
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        showCustomSnackBar("Schedule added successfully", type: SnackBarType.success);
        setState(() {
          selectedPeriod = null;
          selectedClass = null;
          selectedSection = null;
          selectedSubject = null;
        });
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to add schedule");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      setState(() {
        loadingMessage = null;
      });
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
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tell us your Schedule",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "(Your weekly Schedule)",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 25),

                // Day selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: days.map((day) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedDay == day
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selectedDay == day
                                ? Colors.blue
                                : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          day.substring(0, 3),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                selectedDay == day ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 25),

                // Period selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: periods.map((period) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = period['_id'];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: selectedPeriod == period['_id']
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          period['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: selectedPeriod == period['_id']
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),

                // Class selection
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ensures minimal spacing
                    children: [
                      Text(
                        "Select the Class.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4), // Small spacing
                      Text(
                        "(Class you teach in. Leave free periods as empty.)",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
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
                                    subjects = [];
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
                                        subjects = [];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: Text(
                                        classData['className'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              selectedClass == classData['id']
                                                  ? Colors.black
                                                  : Colors.grey,
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
                                    fetchSubjects(sections[index]['id']);
                                  });
                                },
                                itemBuilder: (context, index) {
                                  var sectionData = sections[index];
                                  return GestureDetector(
                                    onTap: () {
                                      if (selectedClass != null) {
                                        setState(() {
                                          selectedSection = sectionData['id'];
                                          fetchSubjects(sectionData['id']);
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        sectionData['sectionName'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: selectedSection == sectionData['id']
                                              ? Colors.black
                                              : Colors.grey,
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
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ensures minimal spacing
                    children: [
                      Text(
                        "Select the Subject.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4), // Small spacing
                      Text(
                        "(Class you teach in. Leave free periods as empty.)",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        var subjectItem = subjects[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSubject = subjectItem['_id'];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: selectedSubject == subjectItem['_id']
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                subjectItem['subjectName'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: selectedSubject == subjectItem['_id']
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedDay != null &&
                            selectedPeriod != null &&
                            selectedClass != null &&
                            selectedSection != null &&
                            selectedSubject != null
                        ? () {
                            addTeacherSchedule();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
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
                child: Loader(
                  text: loadingMessage ?? '',
                ),
              ),
            ),
        ],
      ),
    );
  }
}