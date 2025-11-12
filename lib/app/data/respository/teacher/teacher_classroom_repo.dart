import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/class_detail_model.dart';
import 'package:sheshya/app/data/model/teacher/response/mcq_model.dart';
import 'package:sheshya/app/data/model/teacher/response/subject_model.dart';
import 'package:sheshya/app/data/model/teacher/response/tf_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/helper/custom_print.dart';

class TeacherClassroomRepository {
  static ApiClient apiClient = ApiClient();

  Future<
      (
        bool success,
        List<ClassDetailModel>? classes,
        String message,
      )> getAllClassesList() async {
    final res = await apiClient.get(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.classesList,
    );

    if (res.statusCode == 200) {
      final classes = res.body["data"] as List<dynamic>;
      final classDetails =
          classes.map((e) => ClassDetailModel.fromMap(e)).toList();
      return (true, classDetails, res.body["message"] as String);
    } else {
      return (false, null, res.body["message"] as String);
    }
  }

  Future<
      (
        bool success,
        List<SubjectModel>? subjects,
        String message,
      )> getAllSubjectsByClass({required String className}) async {
    final res = await apiClient.post(
      "/teacher/getAIsubjectList",
      {
        "classId": className,
      },
      baseUrl: ApiConstants.apiBaseUrlNew,
    );
    if (res.statusCode == 200) {
      final subjects = res.body["data"] as List<dynamic>;
      final subjectDetails =
          subjects.map((e) => SubjectModel.fromMap(e)).toList();
      return (true, subjectDetails, res.body["message"] as String);
    } else {
      return (false, null, res.body["message"] as String);
    }
  }

  Future<
      (
        bool success,
        McqModel? mcqModel,
        String message,
      )> generateMcqAssignment({
    required String className,
    required String subjectName,
    required String chapterName,
    required List<String> topics,
    required String questionType,
    required int totalQuestions,
    required String level,
  }) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.generateAssignment,
      {
        "className": className,
        "subject": subjectName,
        "chapter": chapterName,
        "topic": topics.join(", "),
        "ques_type": questionType,
        "num_ques": totalQuestions,
        "level": level,
      },
    );

    try {
      if (res.isOk) {
        return (true, McqModel.fromMap(res.body["data"]), "Success");
      } else {
        return (false, null, "Something went wrong");
      }
    } catch (e) {
      return (false, null, "🔴 Something went wrong: $e");
    }
  }

  Future<
      (
        bool success,
        TfModel? tfModel,
        String message,
      )> generateTfAssignment({
    required String className,
    required String subjectName,
    required String chapterName,
    required List<String> topics,
    required String questionType,
    required int totalQuestions,
    required String level,
  }) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.generateAssignment,
      {
        "className": className,
        "subject": subjectName,
        "chapter": chapterName,
        "topic": topics.join(", "),
        "ques_type": questionType,
        "num_ques": totalQuestions,
        "level": level,
      },
    );

    try {
      if (res.isOk) {
        return (true, TfModel.fromMap(res.body["data"]), "Success");
      } else {
        return (false, null, "Something went wrong");
      }
    } catch (e) {
      return (false, null, "🔴 Something went wrong: $e");
    }
  }

  Future<
      (
        bool success,
        Map<String, dynamic>? fillBlanksModel,
        String message,
      )> generateFillBlanksAssignment({
    required String className,
    required String subjectName,
    required String chapterName,
    required List<String> topics,
    required String questionType,
    required int totalQuestions,
    required String level,
  }) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.generateAssignment,
      {
        "className": className,
        "subject": subjectName,
        "chapter": chapterName,
        "topic": topics.join(", "),
        "ques_type": questionType,
        "num_ques": totalQuestions,
        "level": level,
      },
    );

    try {
      if (res.isOk) {
        return (true, res.body["data"] as Map<String, dynamic>, "Success");
      } else {
        return (false, null, "Something went wrong");
      }
    } catch (e) {
      return (false, null, "🔴 Something went wrong: $e");
    }
  }

  Future<
      (
        bool success,
        Map<String, dynamic>? fillBlanksModel,
        String message,
      )> generateLongQuestionsAssignment({
    required String className,
    required String subjectName,
    required String chapterName,
    required List<String> topics,
    required String questionType,
    required int totalQuestions,
    required String level,
  }) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.generateAssignment,
      {
        "className": className,
        "subject": subjectName,
        "chapter": chapterName,
        "topic": topics.join(", "),
        "ques_type": questionType,
        "num_ques": totalQuestions,
        "level": level,
      },
    );

    try {
      if (res.isOk) {
        return (true, res.body["data"] as Map<String, dynamic>, "Success");
      } else {
        return (false, null, "Something went wrong");
      }
    } catch (e) {
      return (false, null, "🔴 Something went wrong: $e");
    }
  }

  Future<
      (
        bool success,
        List<Map<String, dynamic>>? teacherClasses,
        String message,
      )> getTeacherClasses() async {
    final res = await apiClient.get(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.teacherClasses,
    );

    if (res.statusCode == 200) {
      final classes = res.body["data"] as List<dynamic>;
      final teacherClasses =
          classes.map((e) => e as Map<String, dynamic>).toList();
      return (true, teacherClasses, res.body["message"] as String);
    } else {
      return (false, null, res.body["message"] as String);
    }
  }

  Future<
      (
        bool success,
        String message,
      )> assignAssignment({
    required String sclassId,
    required String assignmentId,
    required String deadline,
  }) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.assignAssignment,
      {
        "sclassId": sclassId,
        "assignmentId": assignmentId,
        "deadline": deadline,
      },
    );
    

    if (res.statusCode == 200) {
      customPrint(res.body["message"] as String);
      return (true, res.body["message"] as String);
    } else {
      customPrint(res.body["message"] as String);
      return (false, res.body["message"] as String);
    }
  }

  Rx<RxStatus> isNotesPdfLoading = RxStatus.loading().obs;
  Rx<RxStatus> isLessonPlanningPdfLoading = RxStatus.loading().obs;

  late Uint8List pdfBytes;
  late File finalFile;
  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxString errorMessage = ''.obs;

  Rx<Completer<PDFViewController>> pdfController =
      Completer<PDFViewController>().obs;

  Future<void> saveFileAppDir(Uint8List data, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      finalFile = File('${directory.path}/$fileName');
      await finalFile.writeAsBytes(data);
      print('PDF saved to: ${finalFile.path}');
    } catch (e) {
      print('Error saving PDF file: $e');
    }
  }
  
  Future<void> generateNotes({
    required String className,
    required String subjectName,
    required String chapterName,
    required String topics,
  }) async {
    final response = await apiClient.post(
      '/teacher/getNotes',
      baseUrl: ApiConstants.apiBaseUrlNew,
      {
        "className": className,
        "subjectName": subjectName,
        "chapterName": chapterName,
        "topicName": topics,
      },
      passToken: true,
      sendBodyBytes: true,
    );
    customPrint(response.body);

    if (response.statusCode == 200) {
      final Uint8List pdfBytesTemp = response.body;
        pdfBytes = pdfBytesTemp;
        await saveFileAppDir(pdfBytesTemp, 'notes_${DateTime.now().millisecondsSinceEpoch}_view.pdf');
      isNotesPdfLoading.value = RxStatus.success();
    } else if (response.statusCode == 400) {
      showCustomSnackBar(response.body['message']);
      isNotesPdfLoading.value = RxStatus.error();
    } else {
      showCustomSnackBar("Something went wrong!");
      isNotesPdfLoading.value = RxStatus.error();
    }
  }

  Future<void> generateLessonPlanning({
    required String className,
    required String subjectName,
    required String topic,
  }) async {
    final response = await apiClient.post(
      '/teacher/lesson-planning',
      baseUrl: ApiConstants.apiBaseUrlNew,
      {
        "className": className,
        "subject": subjectName,
        "topic": topic,
      },
      passToken: true,
      sendBodyBytes: true,
    );

    if (response.statusCode == 200) {
        final Uint8List pdfBytesTemp = response.body;
        pdfBytes = pdfBytesTemp;
        await saveFileAppDir(pdfBytesTemp, 'lesson_planning_${DateTime.now().millisecondsSinceEpoch}_view.pdf');
        isLessonPlanningPdfLoading.value = RxStatus.success();
    } else if (response.statusCode == 400) {
      showCustomSnackBar(response.body['message']);
      isLessonPlanningPdfLoading.value = RxStatus.error();
    } else {
      showCustomSnackBar("Something went wrong!");
      isLessonPlanningPdfLoading.value = RxStatus.error();
    }
  }
}