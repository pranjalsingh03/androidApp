import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import '../../../../../constants/pref_constants.dart';
import 'ai_exam.dart';

class Subject {
  final String id;
  final String name;
  final String notesCount; // This can be fetched dynamically or kept static
  final Widget icon;

  Subject({
    required this.id,
    required this.name,
    required this.notesCount,
    required this.icon,
  });

  // Factory method to create Subject from API response
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['subName'],
      notesCount: '0 Notes', // Default, or update if notes count is provided
      icon: json['image'] != null && json['image'].isNotEmpty
          ? Image.network(json['image'], width: 32, height: 32)
          : const Icon(Icons.book, color: Colors.blue, size: 32),
    );
  }
}

class AiResults extends StatefulWidget {
  const AiResults({super.key});

  @override
  _AiResultsState createState() => _AiResultsState();
}

class _AiResultsState extends State<AiResults> {
  late Future<List<Subject>> _futureSubjects;

  @override
  void initState() {
    super.initState();
    _futureSubjects = fetchSubjects();
  }

  Future<List<Subject>> fetchSubjects() async {
    final token = GetStorage().read(PrefConstants.token);
    const url =
        'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/getPerformanceSubjects';
    final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      return data.map((item) => Subject.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leading: const AppBarBackButton(),
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          'Subjects',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2F3542),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FutureBuilder<List<Subject>>(
            future: _futureSubjects,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Loader(text:"Loading Subjects..."));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No subjects available.'));
              } else {
                final subjects = snapshot.data!;
                return ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return SubjectCard(subject: subjects[index]);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffEAEAEA)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: subject.icon,
        ),
        title: Text(
          subject.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2F3542),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.blue,
        ),
        onTap: () {
          Get.to(() => ExamsPage(subjectId: subject.id));
        },
      ),
    );
  }
}