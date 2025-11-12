class ClassroomHelper {
  static String getTitle({required String type}) {
    switch (type) {
      case "mcq":
        return "MCQ Assessment";
      case "t/f":
        return "True/False";
      case 'fill':
        return "Fill in the Blanks";
      default:
        return "Create Assessment";
    }
  }

  static (String, String) getSubtitle({required String type}) {
    switch (type) {
      case "mcq":
        return ("Create Multiple choice", " assessments for different topics.");
      case "t/f":
        return ("Create True/False Questions", " in just one click.");
      case 'fill':
        return ("Create Fill in the blanks Questions ", " in just one click.");
      default:
        return ("Create Short/Long Questions", "with auto grading");
    }
  }
}
