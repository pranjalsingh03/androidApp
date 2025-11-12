class ApiConstants {
  static const String serverErrorMsg =
      "Opps! Our servers are in a short tea break!";
  static const String networkErrorMsg = "No internet connection";
  static const String defaultErrorMsg =
      "Something went wrong. Please try again later!";

  static const String baseUrl =
      'https://backend-new-app-g6c3bhamergxe9c0.eastus-01.azurewebsites.net';
  static const String chatBaseUrl =
      'https://llama-chat-gnhrhxemc6gyhram.eastus-01.azurewebsites.net';
  static const String apiBaseUrlNew=
  'https://sheshya-backend-deployed-529940359558.asia-south1.run.app';

  static const String chatUri = '/chatLlama/';

  // Teacher Auth
  static const String sendOtpTeacher = '/teacher/sendOtp';
  static const String verifyOtpTeacher = '/teacher/loginByEmailOrPhone';

  static const String sendTeacherEmailOtp = '/teacher/email/sendOtp';
  static const String validateTeacherEmailOtp = '/teacher/email/verifyOtp';

  // Teacher Profile
  static const String teacherProfile = '/teacher/profile';
  static const String teacherGetAttendance = '/teacher/getAttendance';
  static const String teacherCheckLocation = '/teacher/checkDistance';
  static const String teacherMarkAttendance = '/teacher/attendance';
  static const String teacherGetLeaves = '/teacher/getLeaves';
  static const String teacherFeedback = '/teacher/feedback';
  static const String teacherUpdateRecord = "/teacher/updateRecord";
  static const String teacherGetScheduleByDay = '/teacher/getScheduleByDay';
  static const String teacherGetScheduleByDate = '/teacher/getTeacherScheduleByDate';
  static const String getClassDetails = '/teacher/getClassDetails';
  static const String getStudentsListbySection= '/teacher/getStudentsListbySection';

  // Dashboard
  static const String getCurrentClass = '/teacher/current-class';

  // Timetable
  static const String getTimetable = '/teacher/schedule';

  // Attendance
  static const String getClass = '/teacher/classes';
  static const String markAttendance = '/teacher/markStudentAttendance';

  // Class management
  static const String teacherClasses = '/teacher/classes';

  // Classroom
  static const String classesList = '/teacher/getCLassesList';
  static const String getClassStudents = '/teacher/getStudentListBySclass';
  static const String getStudentDetailById = '/teacher/getStudentDetails';
  
  static const String getSclasses = "/teacher/getSclasses";
  
  static const String assignClassTeacher = '/teacher/assign-classTeacher';

  static const String getPeriods = '/teacher/getPeriods';

  static const String getSubjectList = '/teacher/getSubjectList';

  static const String addTeacherSchedule = '/teacher/addTeacherSchedule';

  static const String getStudentAttendance = '/teacher/getStudentAttendance';

  static const String getLeaveByDateAndSclass = '/teacher/getLeaveByDateAndSclass';

  static String getSubjectDetailUri({required String className}) =>
      '/teacher/getSubjectDetails/$className';

  static const String generateAssignment = '/teacher/addAssignment';

  static const String assignAssignment = '/teacher/assignAssignment';

  static const String teacherNotification = '/teacher/getNotifications';



  // Parent Auth
  static const String sendParentMobileOtp = '/students/mobile/sendOtp';
  static const String validateParentMobileOtp = '/students/mobile/verifyOtp';

  static const String sendParentEmailOtp = '/students/email/sendOtp';
  static const String validateParentEmailOtp = '/students/email/verifyOtp';

  static const String getNotificationStudent = '/student/getNotificaions';

  static const String studentApplyLeave = '/student/applyLeave';

  static const String studentGetLeaves = '/student/getLeaveDetails';

  static const String studentGetAttendanceOverview = '/student/getAttendanceOverview';

  static const String studentsGetAttendanceOverviewOfAnyMonthAndYear = '/student/getAttendanceOverviewOfAnyMonthAndYear';

  static const String studentFeedback = '/feedback/sendFeedback';

  // static const String getSubjectDetails = '/getSubjectDetails/allDetails/7th';

  static const String getNotes = '/student/getNotesOfTopic';

  static const String studentProfile = '/student/getStudentDetails';

  static const String studentDetailsUpdate = '/student/updateBasicDetails';

  // static const String getAllTeachersOfAClass = '/getAllTeachersOfAClass';

  static const String parentGetChats = '/getChats';

  static const String parentSendOtpNew='/student/sendOtp';
  static const String parentVerifyOtpNew='/student/loginByEmailOrPhone';
  static const String parentFeesDueNotice='/student/paymentDueNotices';
}
