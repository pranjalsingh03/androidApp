import 'package:sheshya/constants/assets.dart';

final List<ClassroomAction> classroomActions = [
  ClassroomAction(
    title: 'Topic Wrap-up\nTest',
    assetPath: Assets.wrapUp,
    isActive: true,
    type: 'wrapup',
  ),
  ClassroomAction(
    title: 'MCQ\nAssessment',
    assetPath: Assets.mcq,
    isActive: true,
    type: 'mcq',
  ),
  ClassroomAction(
    title: 'Short\nQuestions',
    assetPath: Assets.shortLong,
    isActive: true,
    type: 'short',
  ),
  ClassroomAction(
    title: 'Long\nQuestions',
    assetPath: Assets.shortLong,
    isActive: true,
    type: 'long',
  ),
  ClassroomAction(
    title: 'True/False',
    assetPath: Assets.trueFalse,
    isActive: true,
    type: 't/f',
  ),
  ClassroomAction(
    title: 'Fill in the\nBlanks',
    assetPath: Assets.fillInTheBlanks,
    isActive: true,
    type: 'fill',
  ),
  // ClassroomAction(
  //   title: 'Gen Quest. from\nyour own notes',
  //   assetPath: Assets.fillInTheBlanks,
  //   isActive: true,
  //   type: 'test',
  // ),
];

class ClassroomAction {
  String title;
  String assetPath;
  bool isActive;
  String type;

  ClassroomAction({
    required this.title,
    required this.assetPath,
    required this.isActive,
    required this.type,
  });
}
