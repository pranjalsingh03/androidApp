import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/student/notes/chapter_res_model_notes.dart';
import 'package:sheshya/app/modules/student/notes/get_subject_details_res_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/helper/custom_print.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../parent/parent_home/parent_home_controller.dart';

class NotesController extends GetxController {
  ApiClient apiClient = ApiClient();

  GetSubjectDetailsResModel? getSubjectDetailsResModel;
  Rx<RxStatus> isSubjectDetailsLoading = RxStatus.loading().obs;
  ChapterResModelNotes? chapterResModelNotes;
  Rx<RxStatus> isChapterLoading = RxStatus.loading().obs;

  RxInt selectedSubjectIdx = 0.obs;
  RxInt selectedChapterIdx = 0.obs;
  RxInt selectedTopicIdx = 0.obs;

  Rx<RxStatus> isNotesPdfLoading = RxStatus.loading().obs;

  late Uint8List pdfBytes;
  late File finalFile;
  RxInt pages = 0.obs;
  RxInt currentPage = 0.obs;
  RxBool isReady = false.obs;
  RxString errorMessage = ''.obs;

  Rx<Completer<PDFViewController>> pdfcontroller =
      Completer<PDFViewController>().obs;

  final ParentHomeController parentHomeController = Get.find();

  NotesController();

  @override
  void onInit() {
    super.onInit();
    loadSubjectDetails();
  }

  void loadSubjectDetails() async {
    isSubjectDetailsLoading.value = RxStatus.loading();
    try {
      var res = await apiClient.get('/student/getNotesSubjects', passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);

      if (res.statusCode == 200) {
        getSubjectDetailsResModel = GetSubjectDetailsResModel.fromJson(res.body);
        isSubjectDetailsLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isSubjectDetailsLoading.value = RxStatus.error();
      } else {
        showCustomSnackBar("Something went wrong!");
        isSubjectDetailsLoading.value = RxStatus.error();
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      isSubjectDetailsLoading.value = RxStatus.error();
    }
  }

  void loadSubjectTopicDetails() async {
    isChapterLoading.value = RxStatus.loading();
    try {
      var res = await apiClient.post('/student/getChaptersList', {
        "subjectId": getSubjectDetailsResModel?.data?[selectedSubjectIdx.value].id ?? '',
        "subjectName": getSubjectDetailsResModel?.data?[selectedSubjectIdx.value].subName ?? ''
      }, passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);

      if (res.statusCode == 200) {
        chapterResModelNotes = ChapterResModelNotes.fromJson(res.body);
        isChapterLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isChapterLoading.value = RxStatus.error();
      } else {
        showCustomSnackBar("Something went wrong!");
        isChapterLoading.value = RxStatus.error();
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      isChapterLoading.value = RxStatus.error();
    }
  }

  void loadNotesPdf() async {
    isNotesPdfLoading.value = RxStatus.loading();
    try {
      var res = await apiClient.post(ApiConstants.getNotes,baseUrl: ApiConstants.apiBaseUrlNew, {
        "className": parentHomeController.studentProfileResModel?.data?.academic?.className ?? '',
        "subjectName": getSubjectDetailsResModel?.data?[selectedSubjectIdx.value].subName ?? '',
        "chapterName": chapterResModelNotes?.data?[selectedChapterIdx.value].chapterName ?? '',
        "topicName": chapterResModelNotes?.data?[selectedChapterIdx.value].topics?[selectedTopicIdx.value].topicName ?? '',
      }, passToken: true, sendBodyBytes: true);

      if (res.statusCode == 200) {
        final Uint8List pdfBytesTemp = res.body;
        pdfBytes = pdfBytesTemp;
        await saveFileAppDir(pdfBytesTemp);
        isNotesPdfLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isNotesPdfLoading.value = RxStatus.error();
      } else {
        showCustomSnackBar("Something went wrong!");
        isNotesPdfLoading.value = RxStatus.error();
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      isNotesPdfLoading.value = RxStatus.error();
    }
  }

  Future<void> saveFileAppDir(Uint8List data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      finalFile = File('${directory.path}/notes_${timestamp}_view.pdf');
      await finalFile.writeAsBytes(data);
      print('PDF saved to: ${finalFile.path}');
    } catch (e) {
      print('Error saving PDF file: $e');
    }
  }
}