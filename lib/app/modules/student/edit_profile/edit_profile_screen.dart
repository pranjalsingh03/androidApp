import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';

// class EditProfileScreen extends StatefulWidget {
//   static const routeName = '/edit-profile';
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }


class EditProfileScreen extends GetView<ParentHomeController> {

  final _basicFormKey = GlobalKey<FormState>();
  final _academicFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Fill your data'),
        bottom: TabBar(
          controller: controller.tabController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          tabs: const [
            Tab(text: 'Basic Details'),
            Tab(text: 'Academic Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          basicDetails(context),
          academicDetails(),
        ],
      ),
    );
  }

  Container academicDetails() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      height: Get.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _academicFormKey,
          child: Column(
            children: [
              CustomTextField(
                label: "School Name",
                // initialValue: "Meena Kumari",
                textEditingController:controller.schoolName,
              ),
              CustomTextField(
                label: "Class",
                // initialValue: "meenakumari92@gmail.com",
                textEditingController: controller.classController,
              ),
              CustomTextField(
                label: "Roll Number",
                // initialValue: "09888727212",
                textEditingController: controller.rollNumber,
              ),
              CustomTextField(
                label: "Montly Fees",
                // initialValue: "Cricket",
                textEditingController: controller.monthlyFeePayable,
              ),
              // CustomTextField(
              //   label: "Goals",
              //   // initialValue: "Smash",
              //   textEditingController: TextEditingController(),
              // ),
              // CustomTextField(
              //   label: "Optional Subject - 1",
              //   // initialValue: "French",
              //   isBordered: false,
              //   textEditingController: TextEditingController(),
              // ),
              // CustomTextField(
              //   label: "Optional Subject - 2",
              //   // initialValue: "Japanese",
              //   isBordered: false,
              //   textEditingController: TextEditingController(),
              // ),
              // CustomTextField(
              //   label: "Caste Certificate",
              //   // initialValue: "OBC",
              //   textEditingController: TextEditingController(),
              // ),
              // Container(
              //   width: Get.width - 32,
              //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
              //   decoration: UiConstants.defaultDecoration,
              //   child: Wrap(
              //     alignment: WrapAlignment.center,
              //     spacing: 8.w,
              //     crossAxisAlignment: WrapCrossAlignment.center,
              //     runAlignment: WrapAlignment.center,
              //     children: [
              //       Icon(
              //         CupertinoIcons.cloud_upload,
              //         size: 16.h,
              //         color: AppColors.primaryColor,
              //       ),
              //       const Text("Upload your Caste Certificate")
              //     ],
              //   ),
              // ),
              SizedBox(height: 16.h),
              // ElevatedButton(
              //     onPressed: () {}, child: const Text("Save Changes"))
            ],
          ),
        ),
      ),
    );
  }

  Container basicDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      height: Get.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _basicFormKey,
          child: Column(
            children: [

              CustomTextField(
                label: "Name",
                // initialValue: "",
                textEditingController: controller.nameController,
              ),
              CustomTextField(
                label: "Registered Email",
                textEditingController: controller.emailController,
              ),
              CustomTextField(
                label: "Registered Phone Number",
                textEditingController: controller.phoneNumberController,
              ),
              CustomTextField(
                label: "Gender",
                textEditingController:controller.genderController,
              ),
              // CustomTextField(
              //   label: "Age",
              //   textEditingController: controller.dobController,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "DOB",
                    textAlign: TextAlign.left,
                    style: UiConstants.dark_10_400,
                  ),
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: (){
                      pickDate(context);
                    },
                    child: TextField(
                      controller: controller.dobController,
                      // initialValue: _initialValue ?? "",
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      cursorColor: AppColors.primaryColor,
                      style: UiConstants.dark_14_400,
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: null,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
              CustomTextField(
                label: "Father’s Name",
                textEditingController: controller.fatherNameController,
              ),
              CustomTextField(
                label: "Mother’s Name",
                textEditingController: controller.motherNameController,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(onPressed: () {
                controller.updateStudentDetails();
              }, child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the DatePicker
  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate ?? DateTime.now(), // Default date
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2100), // Latest date
    );

    if (pickedDate != null && pickedDate != controller.selectedDate) {
      controller.selectedDate = pickedDate;
      controller.dobController.text = controller.dateFormatter.format(pickedDate);
    }
  }
}

class CustomTextField extends StatelessWidget {
  final String _label;
  // final String? _initialValue;
  final bool isBordered;
  final TextEditingController textEditingController;
  const CustomTextField({
    super.key,
    required String label,
    // required String? initialValue,
    this.isBordered = false,
    required this.textEditingController,
  })  : _label = label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          _label,
          textAlign: TextAlign.left,
          style: UiConstants.dark_14_400,
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: textEditingController,
          // initialValue: _initialValue ?? "",
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          cursorColor: AppColors.primaryColor,
          style: UiConstants.dark_14_400,
          decoration: InputDecoration(
            enabledBorder: isBordered
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.textColor),
                  )
                : null,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
