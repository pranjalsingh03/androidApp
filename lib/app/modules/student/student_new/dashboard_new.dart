import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';
import 'package:sheshya/app/modules/parent/parent_notification/parent_notification_screen.dart';
import 'package:sheshya/app/modules/parent/profile/parent_profile_screen.dart';
import 'package:sheshya/app/modules/student/schedule_screen.dart';
import 'package:sheshya/app/modules/student/student_new/classroom/dashboard_view_classroom.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentDashboard extends GetView<ParentHomeController> {
  @override
  final ParentHomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // padding: EdgeInsets.all(16),
          
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(),
            // School Progress
            Container(
              padding: EdgeInsets.all(12),
            child: _buildSchoolProgress(),
            ),
            // SizedBox(height: 20),
            // // Progress Board
            // Container(
            //   padding: EdgeInsets.all(12),
            // child: _buildProgressBoard(),
            // ),
            SizedBox(height: 20),
            // Subjects
            Container(
              padding: EdgeInsets.all(12),
            child: _buildSubjects(),
            ),
            SizedBox(height: 20),
            // Additional Sections
            
            _buildCourseAndCareer(),
            SizedBox(height: 20),
            // Weaknesses
            Container(
              padding: EdgeInsets.all(12),
            child: _buildWeaknessSection(),
            ),
            // _buildWeaknessSection(),
            SizedBox(height: 20),
            // Body Metrics
            Container(
              padding: EdgeInsets.all(12),
            child: _buildBodyMetrics(),
            ),
            SizedBox(height: 20),
            // Olympiad Scholarships
            // Container(
            //   padding: EdgeInsets.all(12),
            // child:_buildOlympiadSection(),
            // ),
            // SizedBox(height: 20),
            // // Online Tutors
            // Container(
            //   padding: EdgeInsets.all(12),
            //   child: _buildOnlineTutors(),
            //   ),
            // // _buildOnlineTutors(),
          ],
        ),
      ),
      ),
    );
  }

Container appBar() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      width: Get.width.w,
      height: UiConstants.appBarHeight.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(controller.studentProfileResModel?.data?.basic?.name ?? '--',
              style: UiConstants.appBarTitle.copyWith(fontSize: 17.sp)),
          const SizedBox(width: 14),
          // SvgPicture.asset(AssetsConstants.arrowDown),
          const Spacer(),
          IconButton(onPressed: ()=> Get.to(SchedulePage()), icon: SvgPicture.asset(AssetsConstants.calendar)),
          IconButton(
            onPressed: () => Get.to(() => ParentProfileScreen()),
            icon: SvgPicture.asset(
              AssetsConstants.userProfile,
              height: 28.h,
              width: 28.w,
            ),
          ),
        ],
      ),
    );
}

Widget _buildSchoolProgress() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("School Progress (Term I)", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Week 03"),
          SizedBox(height: 5),
          LinearProgressIndicator(value: 0.8, backgroundColor: Colors.grey[300], valueColor: AlwaysStoppedAnimation(Colors.blue)),
          SizedBox(height: 5),
          Text("80%"),
        ],
      ),
    );
  }

Widget _buildProgressBoard() {
  final List<List<bool>> progressData = [
    [true, true, true, true, true, true, true, true, true, true], // English
    [true, true, true, true, true, true, true, true, true, false], // Math
    [true, true, true, true, false, false, false, false, false, false], // Science
    [true, true, true, true, true, true, true, true, false, false], // S. Science
    [true, true, true, false, false, false, false, false, false, false], // Hindi
  ];

  final List<String> subjects = [
    "English",
    "Math",
    "Science",
    "S.Science",
    "Hindi"
  ];

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: const BorderSide(color: Colors.transparent),
    ),
    shadowColor: Colors.transparent,
    color: AppColors.whiteColor,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Progress Board",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Column(
            children: List.generate(progressData.length, (index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Subject name
                  
                  // Progress row
                  Expanded(
                    child: Row(
                      children: progressData[index].map((completed) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: completed
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 80, // Fixed width for alignment
                    child: Text(
                      textAlign: TextAlign.right,
                      subjects[index],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("High Priority",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 110),
              Text("Low Priority",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    ),
  );
}

  

Widget _buildSubjects() {

  final List<Map<String, String>> subjects = [
    {"name": "English", "image": "assets/new_images/english.png"},
    {"name": "Maths", "image": "assets/new_images/math.png"},
    {"name": "Chemistry", "image": "assets/new_images/chemistry.png"},
  ];

  
    return Container(
      height: 150, // Set height for the slider
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return _buildSubjectCard(subjects[index]["name"]!, subjects[index]["image"]!);
        },
      ),
    );
  }

Widget _buildSubjectCard(String subjectName, String imagePath) {
    return GestureDetector(
      onTap: () {
        Get.to(()=> DashboardViewClassroom());
      },
      child: SizedBox(
        width: 150,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
            Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AssetsConstants.notificationNew,
                      height: 20.h,
                      width: 20.w,
                    ),
                    onPressed: () {
                      print("$subjectName notification clicked");
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "3", // Replace with dynamic notification count
                      style: TextStyle(
                        color: UiConstants.dark_14_400.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                subjectName,
                style: TextStyle(
                  color: UiConstants.dark_14_400.color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    ),
    );
  }



Widget _buildCourseAndCareer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInfoCard("Ai Tutor", AssetsConstants.carrerCouncelling, AppColors.newStudentCourse, Color(0xFF001258),"Boosts your Exam prepat your pace, according to your Goals"),
        // _buildInfoCard("Career Counseling", AssetsConstants.carrerCouncelling, AppColors.newStudentCareer, Color(0xFF332C3E),"Figure out the most important part of you life."),
      ],
    );
  }

Widget _buildInfoCard(String title, String imagePath ,Color backgroundColor, Color textColor, String about) {
  return Container(
    width:380 , // Adjust width as needed
    height: 160, // Adjust height to fit image & text
    decoration: BoxDecoration(
      color: backgroundColor, // Solid blue background
      borderRadius: BorderRadius.circular(25), // Rounded corners
    ),
    padding: EdgeInsets.only(left: 10), // Padding inside the box
    child: Card(
      elevation: 0,
      color: backgroundColor, // Same color as parent container
      child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    // Add the image


    // The column with text and button
    Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8), // Space between image and text
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor, // White text for better contrast
            ),
          ),
          Text(
            about,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white, // White text for better contrast
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.whiteColor,
              // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            child: Text(
              "Start Learning",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff95DBFA), // White text for better contrast
              ),
            ),
          ),
          SizedBox(height: 18), // Space between text and image
        ],
      ),
    ),
    //     Container(
    //   width: 100,
    //   height: 100,
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage(imagePath),
    //       fit: BoxFit.contain,
    //     ),
    //     // borderRadius: BorderRadius.circular(25), // Rounded corners
    //   ),
    // ),
  ],
),
    ),
  );
}



Widget _buildWeaknessSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color:AppColors.strokeColor)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weakness",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildTag("Language Problem", isSelected: true),
            _buildTag("Confidence"),
            _buildTag("Math Concepts"),
            _buildTag("Biology"),
          ],
        ),
        SizedBox(height: 12),
        Text(
          "Struggles with comprehension and forming structured answers. Difficulty understanding complex exam questions.",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    ),
  );
}

Widget _buildTag(String text, {bool isSelected = false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.grey[300],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildBodyMetrics() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color:AppColors.strokeColor)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Body Metrics",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "BMI",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5),
                Text(
                  "4.8",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.person, size: 18, color: Colors.grey),
            SizedBox(width: 5),
            Text(
              "Current Weight",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          "43.700 Kg",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.arrow_upward, size: 18, color: Colors.green),
            SizedBox(width: 5),
            Text(
              "2.3 Kg",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "19th March, 2025",
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        SizedBox(height: 10),
        Text(
          "Body weight increased in the past 3 months. Concentrate on high-protein meals and daily physical activity for better growth results.",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    ),
  );
}


Widget _buildOlympiadSection() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Color(0xFF34A853), // Green background
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Olympiads Scholarships",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Know and Apply to Olympiads and scholarship across India.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        SvgPicture.asset(
          AssetsConstants.olympiadNew,
          height: 100,
        ),
      ],
    ),
  );
}

Widget _buildOnlineTutors() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Online Tutors",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Elite Tutors with years of experience starting at:",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(
                text: "₹499 ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "Per Hour",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            // Add your navigation or action here
          },
          child: Text(
            "Start your first session for free!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

}