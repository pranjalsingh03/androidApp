import 'package:get/get.dart';
import 'package:sheshya/app/data/model/teacher/response/class_detail_model.dart';
import 'package:sheshya/app/data/model/teacher/response/subject_model.dart';

import 'package:sheshya/app/modules/teacher/ai_chat/views/ai_chat_view.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/notes_screen.dart';

class TeacherClassroomController extends GetxController {
  int selectedIndex = 1;

  ClassDetailModel? selectedClass;
  SubjectModel? selectedSubject;

  void updateSelectedIndex(int index) {
    if (index == 0) {
      Get.back();
    } else if (index == 3) {
      Get.to(() => const AiChatView());
      index = 1;
   } else if (index == 4) {
      Get.to(() =>  NotesScreen());
      index = 1;
    } else {
      selectedIndex = index;
    }
    update();
  }

  void updateSelectedClassAndSubject({
    required ClassDetailModel classDetailModel,
    required SubjectModel subjectModel,
  }) {
    selectedClass = classDetailModel;
    selectedSubject = subjectModel;
    update();
  }

  Future<void> assignAssignment({
    required String assigmentId,
    required String deadline,
  }) async {
    // await ApiService.assignAssignment(
    //     assigmentId: assigmentId, deadline: deadline);
  }
}
