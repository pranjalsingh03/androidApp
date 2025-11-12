import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sheshya/components/app_bar_back_button.dart';

import '../../../../../constants/pref_constants.dart';
import 'notes_topic.dart';

class NotesChapter extends StatefulWidget {
  final String subjectId;
  final String subjectName;

  const NotesChapter({
    Key? key,
    required this.subjectId,
    required this.subjectName,
  }) : super(key: key);

  @override
  _NotesChapterState createState() => _NotesChapterState();
}

class _NotesChapterState extends State<NotesChapter> {
  late Future<List<NoteItem>> _futureNotes;

  @override
  void initState() {
    super.initState();
    _futureNotes = fetchChapters(widget.subjectId, widget.subjectName);
  }

  Future<List<NoteItem>> fetchChapters(String subjectId, String subjectName) async {
    final token = GetStorage().read(PrefConstants.token);
    const url =
        'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/getChaptersList';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json','Authorization':'Bearer $token'},
      body: json.encode({
        "subjectId": subjectId,
        "subjectName": subjectName,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      // Convert JSON to a list of NoteItem objects
      return data.map<NoteItem>((chapter) {
        return NoteItem(
          title: chapter['chapter_name'],
          chapterId: chapter['chapter_id'],
          topicCount: chapter['topics']?.length ?? 0,
          topics: chapter['topics'] != null
              ? List<Topic>.from(
            chapter['topics'].map((topic) => Topic.fromJson(topic)),
          )
              : [],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch chapters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        elevation: 0,
        leading: const AppBarBackButton(),
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Color(0xFF2E4052),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NoteItem>>(
        future: _futureNotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No chapters available.'));
          } else {
            final notes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteCard(note: notes[index]);
              },
            );
          }
        },
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final NoteItem note;

  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NotesTopic(notes:note.topics));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEAEAEA)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),

        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E4052),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${note.topicCount} Topics',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteItem {
  final String title;
  final String chapterId;
  final int topicCount;
  final List<Topic> topics;

  NoteItem({
    required this.title,
    required this.chapterId,
    required this.topicCount,
    required this.topics,
  });
}

class Topic {
  final String topicName;
  final String topicId;

  Topic({required this.topicName, required this.topicId});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicName: json['topic_name'],
      topicId: json['topic_id'],
    );
  }
}
