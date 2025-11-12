import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'package:sheshya/app/modules/student/ai_classroom/notes/notes_chapter.dart';
import 'package:sheshya/components/app_bar_back_button.dart';

import '../../../../../constants/pref_constants.dart';

class NotesTopic extends StatefulWidget {
  final List<Topic> notes;
  const NotesTopic({super.key, required this.notes});

  @override
  _NotesTopicState createState() => _NotesTopicState();
}

class _NotesTopicState extends State<NotesTopic> {
  bool isLoading = false;
  String? downloadingTopic;

  Future<void> downloadPDF(String topicName) async {
    setState(() {
      isLoading = true;
      downloadingTopic = topicName;
    });

    final token = GetStorage().read(PrefConstants.token);

    try {
      var response = await http.post(
        Uri.parse("https://sheshya-backend-deployed-529940359558.asia-south1.run.app/student/getNotesOfTopic"),
        headers: {"Content-Type": "application/json",'Authorization':'Bearer $token'},
        body: '''
          {
            "className": "KG1",
            "subjectName": "English",
            "chapterName": "Nouns",
            "topicName": "Proper Nouns"
          }
        ''',
      );

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File("${directory.path}/$topicName.pdf");
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
          isLoading = false;
          downloadingTopic = null;
        });

        // Show PDF preview
        showPDFPreview(file.path);
      } else {
        _showError("Failed to download PDF");
      }
    } catch (e) {
      _showError("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
        downloadingTopic = null;
      });
    }
  }

  void showPDFPreview(String path) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("PDF Preview"),
        content: SizedBox(
          height: 400,
          child: PDFView(filePath: path),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          ElevatedButton(
            onPressed: () => OpenFile.open(path),
            child: Text("Download PDF"),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.notes.length,
        itemBuilder: (context, index) {
          return NoteCard(
            note: widget.notes[index],
            isLoading: isLoading && downloadingTopic == widget.notes[index].topicName,
            onDownload: () => downloadPDF(widget.notes[index].topicName),
          );
        },
      ),
    );
  }
}


class NoteCard extends StatelessWidget {
  final Topic note;
  final bool isLoading;
  final VoidCallback onDownload;

  const NoteCard({
    super.key,
    required this.note,
    required this.isLoading,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.description_outlined,
                color: Colors.grey[400],
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.topicName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E4052),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "date",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            // Download button with loader
            isLoading
                ? CircularProgressIndicator()
                : IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.black54,
              ),
              onPressed: onDownload,
            ),
          ],
        ),
      ),
    );
  }
}
