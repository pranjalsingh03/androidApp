import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/helper/custom_print.dart';
import '../../../../constants/pref_constants.dart';
import 'package:get/get.dart';

class Question {
  final String id;
  final String questionText;
  final List<String>? options;
  final String correctAnswer;
  final String questionType;

  Question({
    required this.id,
    required this.questionText,
    this.options,
    required this.correctAnswer,
    required this.questionType,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      questionText: json['question'],
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correctAnswer'],
      questionType: json['ques_type'],
    );
  }
}

class TestScreen extends StatefulWidget {
  final String testId;
  final String testName;
  const TestScreen({super.key, required this.testId, required this.testName});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Future<List<Question>> futureQuestions;
  int currentQuestionIndex = 0;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _remainingSeconds = 0;
  String? selectedAnswer;
  List<String?> answers = [];
  TextEditingController _answerController = TextEditingController(); // Controller for the input
  bool isSubmitting = false; // Track submission state

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions(widget.testId);
  }

  Future<List<Question>> fetchQuestions(String testId) async {
    final token = GetStorage().read(PrefConstants.token);
    final response = await http.post(
      Uri.parse(
          'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/fetchTestById'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({"testId": testId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final questions = data['questions'] as List;
      answers = List.filled(questions.length, null);

      int testDuration = data['duration'] * 60; // Convert minutes to seconds
      startCountdown(testDuration);

      return questions.map((q) => Question.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load test');
    }
  }

  void startCountdown(int seconds) {
    _remainingSeconds = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
        // Handle time's up logic here if needed
      }
    });
  }

  String get countdownText {
    int minutes = _remainingSeconds ~/ 60;
    int remainingSeconds = _remainingSeconds % 60;

    if (_remainingSeconds >= 60) {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')} Min';
    } else {
      return '${remainingSeconds.toString().padLeft(2, '0')} Sec';
    }
  }

  void submitTest() async {
    setState(() {
      isSubmitting = true; // Show loader
    });

    try {
      final token = GetStorage().read(PrefConstants.token);

      // Wait for the future to resolve if it hasn't already
      final questions = await futureQuestions;

      // Create the responses list with resolved question texts
      final responses = answers.asMap().entries.map((entry) {
        final questionIndex = entry.key;
        final answer = entry.value;
        return {
          "question": questions[questionIndex].questionText, // Directly use resolved question text
          "studentAnswer": answer ?? "",
        };
      }).toList();

      final body = {
        "assignmentId": widget.testId,
        "responses": responses,
      };
      customPrint(json.encode(body));

      final response = await http.post(
        Uri.parse(
            'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/saveStudentResponses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        customPrint("Test submitted successfully");
        Get.back();
        Get.back();
        // Get.until((route) => Get.currentRoute == "/testList");
      } else {
        Get.snackbar("Error", "Failed to submit test.");
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred while submitting the test: $error");
    } finally {
      setState(() {
        isSubmitting = false; // Hide loader
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    _answerController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Question>>(
            future: futureQuestions,
            builder: (context, snapshot) {
              if (isSubmitting) {
                return const Center(child: Loader(text: "Submitting the test..."));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Loader(text: "Loading ${widget.testName}",));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final questions = snapshot.data!;
                return buildTestScreenContent(questions);
              } else {
                return const Center(child: Text('No questions available.'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTestScreenContent(List<Question> questions) {
    final currentQuestion = questions[currentQuestionIndex];
    final isMCQ = currentQuestion.questionType.toUpperCase() == 'MCQ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            AppBarBackButton(),
            Expanded(
              child: Text(
                widget.testName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2F3542),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              'Total Questions | ${questions.length}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Question Navigator
        buildQuestionNavigator(questions),

        // Timer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              countdownText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2F3542),
              ),
            ),
            Text(
              currentQuestion.questionType,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2F3542),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Current Question
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xffEAEAEA)),
              borderRadius: BorderRadius.circular(8)
          ),
          child: Text(
            'Q.${currentQuestionIndex + 1} ${currentQuestion.questionText}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Options or Answer Input
        Expanded(
          child: isMCQ ? buildOptions(currentQuestion) : buildAnswerInput(),
        ),

        // Navigation Buttons
        buildNavigationButtons(questions),
      ],
    );
  }

  Widget buildOptions(Question question) {
    return ListView.builder(
      itemCount: question.options!.length,
      itemBuilder: (context, index) {
        String option = question.options![index];
        bool isSelected = selectedAnswer == option;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: ListTile(
            onTap: () {
              setState(() {
                selectedAnswer = option;
                answers[currentQuestionIndex] = option;
              });
            },
            title: Text(
              'Option ${String.fromCharCode(65 + index)}: $option',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.blue)
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget buildAnswerInput() {
    _answerController.text = answers[currentQuestionIndex] ?? ''; // Ensure controller is updated with the current answer

    return Container(
      height: 150, // Adjust height as needed
      child: TextField(
        controller: _answerController, // Use the controller
        keyboardType: TextInputType.multiline, // Enable multiline keyboard input
        maxLines: null, // Allows unlimited lines
        minLines: 1, // Minimum 1 line
        decoration: const InputDecoration(
          hintText: 'Enter your answer',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            answers[currentQuestionIndex] = value; // Update the answers list on input change
          });
        },
      ),
    );
  }

  Widget buildNavigationButtons(List<Question> questions) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              if (currentQuestionIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentQuestionIndex--;
                        selectedAnswer = answers[currentQuestionIndex];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Previous Question',
                      style: TextStyle(
                        color: Color(0xFF2C87FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 16),
              if (currentQuestionIndex < questions.length - 1)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentQuestionIndex++;
                        selectedAnswer = answers[currentQuestionIndex];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Next Question',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (currentQuestionIndex == questions.length - 1)
            Center(
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitTest, // Disable button while submitting
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isSubmitting
                    ? const Loader(text: "Submitting the test...") // Show loader while submitting
                    : const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildQuestionNavigator(List<Question> questions) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              bool isCurrent = index == currentQuestionIndex;
              bool isAnswered = answers[index] != null;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentQuestionIndex = index;
                    selectedAnswer = answers[index];
                  });
                },
                child: Container(
                  width: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? Colors.blue
                        : isAnswered
                            ? Colors.orange
                            : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: isCurrent || isAnswered
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildLegendItem(Colors.blue, 'Current'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.white, 'Unanswered'),
            const SizedBox(width: 16),
            _buildLegendItem(Colors.orange, 'Answered'),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: color == Colors.white
                ? Border.all(color: Colors.grey.shade300)
                : null,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF2F3542),
          ),
        ),
      ],
    );
  }
}