import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sheshya/app/data/const_data/subjects_data.dart';
import 'package:sheshya/app/modules/student/ai_classroom/test_details.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import '../../../../constants/pref_constants.dart';


class GetTestOfSubject extends StatefulWidget {
  final String subjectId;
  final String name;

  const GetTestOfSubject({super.key, required this.subjectId, required this.name});

  @override
  State<GetTestOfSubject> createState() => _GetTestOfSubjectState();
}

class _GetTestOfSubjectState extends State<GetTestOfSubject> {
  String currentTab = 'All';
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';
  Map<String, List<Test>> tabData = {
    'All': [],
    'Pending': [],
    'Submitted': [],
    'Overdue': [],
  };

  @override
  void initState() {
    super.initState();
    fetchTests();
  }

  Future<void> fetchTests() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    final token = GetStorage().read(PrefConstants.token);
    const String url = 'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/fetchTests';
    final Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final Map<String, dynamic> body = {
      "subjectId":widget.subjectId,
      "date": DateTime.now().toIso8601String().split('T')[0], // Current date
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          final List<dynamic> tests = responseData['data'];
          setState(() {
            for (var test in tests) {
              final testObj = Test.fromJson(test);

              tabData['All']?.add(testObj);

              if (testObj.dueDay == 'Submitted') {
                tabData['Submitted']?.add(testObj);
              } else if (testObj.dueDay == 'Overdue') {
                tabData['Overdue']?.add(testObj);
              } else {
                tabData['Pending']?.add(testObj);
              }
            }
            isLoading = false;
          });
        } else {
          throw Exception(responseData['message'] ?? 'Failed to fetch tests.');
        }
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        // backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: Loader(text: "Loading Tests for ${widget.name}",))
          : hasError
          ? Center(child: Text('Error: $errorMessage'))
          : Column(
        children: [
          Container(
            // color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (String tab in ['All', 'Pending', 'Submitted', 'Overdue'])
                    ...[
                      if (tab != 'All') const SizedBox(width: 12),
                      _TabButton(
                        text: tab,
                        isSelected: currentTab == tab,
                        onTap: () {
                          setState(() {
                            currentTab = tab;
                          });
                        },
                      ),
                    ],
                ],
              ),
            ),
          ),
          Expanded(
            child: tabData[currentTab]?.isEmpty ?? true
                ? const Center(
              child: Text(
                'No Assignment',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tabData[currentTab]?.length ?? 0,
              itemBuilder: (context, index) {
                final cardData = tabData[currentTab]![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: QuizCard(
                    testId: cardData.id,
                    subject:widget.name,
                    subjectId:widget.subjectId,
                    image: cardData.image,
                    title: cardData.topic,
                    subtitle: cardData.chapter,
                    date: cardData.formattedDate,
                    author: 'ANURAG SINGH',
                    dueDay: cardData.dueDay,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2F6BFF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xff374957),
            fontSize: 14,
            fontFamily: "Lufga",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final String subject;
  final String subjectId;
  final String testId;
  final String image;
  final String title;
  final String subtitle;
  final String date;
  final String author;
  final String dueDay;

  const QuizCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.author,
    required this.dueDay,
    required this.image, required this.subject, required this.subjectId, required this.testId,
  });

  Color _getStatusColor(String dueDay) {
    switch (dueDay) {
      case 'Submitted':
        return Colors.green;
      case 'Pending':
        return Colors.yellow.shade700;
      case 'Overdue':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusMessage(String dueDay) {
    if (dueDay == 'Submitted' || dueDay == 'Pending') {
      return dueDay; // Directly show the status (Submitted or Pending)
    } else if (dueDay == 'Overdue') {
      return 'DUE : Overdue'; // Show "DUE" prefix for Overdue
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(dueDay!='Submitted'){
          Get.to(()=>TestDetails(id: testId, image: image, chapter: subject, test: title, date: dueDay, chapterId: subjectId,));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffEAEAEA))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Image.network(
                  image, // Replace with your actual image URL
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.calculate,
                      size: 60,
                      color: Colors.orange,
                    );
                  },
                ),
              ),
            ),
            Container(decoration: BoxDecoration(color: Colors.grey),width: double.infinity,height: 0.2,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getStatusMessage(dueDay),
                    style: TextStyle(
                      color: _getStatusColor(dueDay),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Test {
  final String id;
  final String chapter;
  final String topic;
  final String assignmentType;
  final bool isSubmitted;
  final bool isOverdue;
  final String level;
  final String deadline;
  final String image;

  Test({
    required this.id,
    required this.chapter,
    required this.topic,
    required this.assignmentType,
    required this.isSubmitted,
    required this.isOverdue,
    required this.level,
    required this.deadline,
    required this.image
  });

  // Factory method to create Test object from JSON
  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      chapter: json['chapter'],
      topic: json['topic'],
      assignmentType: json['assignmentType'],
      isSubmitted: json['isSubmitted'],
      isOverdue: json['isOverdue'],
      level: json['level'],
      deadline: json['deadline'],
      image: json['image']??'https://img.freepik.com/free-vector/illustration-notebook-icon_53876-5858.jpg'
    );
  }

  // Method to format the date from the deadline
  String get formattedDate {
    return DateTime.parse(deadline).toLocal().toString().split(' ')[0];
  }

  // Method to determine the due day status
  String get dueDay {
    if (isSubmitted) return 'Submitted';
    if (isOverdue) return 'Overdue';
    return 'Pending';
  }
}

