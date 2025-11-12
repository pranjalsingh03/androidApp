import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/widgets/avatar.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/datetime_helper.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/theme/app_colors.dart';

class TeacherEditProfileScreen extends StatefulWidget {
  const TeacherEditProfileScreen({super.key});

  @override
  State<TeacherEditProfileScreen> createState() =>
      _TeacherEditProfileScreenState();
}

class _TeacherEditProfileScreenState extends State<TeacherEditProfileScreen> {
  final TeacherProfileController teacherProfileController =
      Get.find<TeacherProfileController>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNoController = TextEditingController();
  final dobController = TextEditingController();
  final joiningDateController = TextEditingController();

  // Add this variable to manage gender selection
  String selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    nameController.text = teacherProfileController.teacherProfileModel!.name;
    emailController.text = teacherProfileController.teacherProfileModel!.email;
    contactNoController.text =
        teacherProfileController.teacherProfileModel!.phoneNo;
    dobController.text = DateTimeHelper.ddmmyyyy(
        date: teacherProfileController.teacherProfileModel?.dob ?? "");
    joiningDateController.text = DateTimeHelper.ddMMMMyyyy(
        date: teacherProfileController.teacherProfileModel?.joiningDate ?? "");

    // Initialize gender from teacher profile
    selectedGender =
        teacherProfileController.teacherProfileModel?.gender ?? "Male";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherProfileController>(builder: (controller) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUi.defaultStyle,
        child: Scaffold(
          appBar: AppBar(
            leading: const AppBarBackButton(),
            title: const Text('Edit Profile'),
          ),
          body: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.defaultPadding,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: AvatarComponent(
                        image: controller.teacherProfileModel!.imageUrl ?? 'https://via.placeholder.com/150',
                      ),
                    ),
                  ),
                  k20YGap,
                  k20YGap,
                  // Name
                  Text("Name", style: kSecondary_10_400),
                  k6YGap,
                  TextField(
                    controller: nameController,
                    style: kDark_12_400,
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                  kdefaultYGap,
                  // Email
                  Text("Email", style: kSecondary_10_400),
                  k6YGap,
                  TextField(
                    controller: emailController,
                    style: kDark_12_400,
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  kdefaultYGap,
                  // Contact No
                  Text("Contact No.", style: kSecondary_10_400),
                  k6YGap,
                  TextField(
                    controller: contactNoController,
                    style: kDark_12_400,
                    keyboardType: TextInputType.phone,
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      hintText: 'Enter your contact no',
                    ),
                  ),

                  kdefaultYGap,
                  // Gender
                  Text("Gender", style: kSecondary_10_400),
                  k6YGap,
                  DropdownButtonFormField<String>(
                    elevation: 1,
                    dropdownColor: AppColors.whiteColor,
                    value: selectedGender,
                    decoration: const InputDecoration(
                      hintText: 'Select gender',
                    ),
                    icon: SvgPicture.asset(Assets.arrowDown),
                    style: kDark_12_400,
                    items: ['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                  ),
                  kdefaultYGap,
                  // DOB
                  Text("DOB", style: kSecondary_10_400),
                  k6YGap,
                  TextField(
                    controller: dobController,
                    style: kDark_12_400,
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      hintText: 'Enter your DOB',
                    ),
                  ),
                  kdefaultYGap,
                  Text("Joining Date", style: kSecondary_10_400),
                  k6YGap,
                  TextField(
                    controller: joiningDateController,
                    enabled: false,
                    style: kDark_12_400,
                    onTapOutside: (value) => FocusScope.of(context).unfocus(),
                    decoration: const InputDecoration(
                      hintText: '--/--/----',
                    ),
                  ),
                  kdefaultYGap,
                  CustomButton(
                    buttonText: "Save Changes",
                    onPressed: () {},
                  ),
                  kdefaultYGap,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
