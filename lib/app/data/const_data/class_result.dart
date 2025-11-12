final classResultList = [
  ClassResult(
    className: "8th",
    section: "B",
    topic: "Light",
  ),
  ClassResult(
    className: "9th",
    section: "A",
    topic: "Law of Motion",
  ),
  ClassResult(
    className: "10th",
    section: "B",
    topic: "Light",
  ),
];

final studentResultList = [
  StudentResult(name: "Arav Anand", marks: "85"),
  StudentResult(name: "Anurag Singha", marks: "72"),
  StudentResult(name: "Ayush Kumar", marks: "75"),
  StudentResult(name: "Deepanshu Thakur", marks: "89"),
];

class ClassResult {
  final String className;
  final String section;
  final String topic;

  ClassResult({
    required this.className,
    required this.section,
    required this.topic,
  });
}

class StudentResult {
  final String name;
  final String marks;

  StudentResult({
    required this.name,
    required this.marks,
  });
}
