import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/parent/parent_add_card/parent_card_add_screen.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/app/modules/parent/parent_pay_later_screen/parent_pay_later_screen.dart';

class ParentPaymentMethodScreen extends StatefulWidget {
  static const routeName = "/parent-payment-method";

  const ParentPaymentMethodScreen({super.key});

  @override
  State<ParentPaymentMethodScreen> createState() =>
      _ParentPaymentMethodScreenState();
}

class _ParentPaymentMethodScreenState extends State<ParentPaymentMethodScreen> {
  List<String> paymentOptions = ["Credit & Debit\nCard", "UPI", "Pay Later"];
  List<String> upiIcons = [
    "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/google-pay-icon.png",
    "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/phonepe-icon.png",
    "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/paytm-icon.png",
    "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/upi-payment-icon.png"
  ];
  List<String> upiTitles = ["GPay", "PhonePe", "Paytm", "Add Upi"];

  int selectedIndex = 0;
  bool isCardSelected = false;
  bool isUpiSelected = false;
  bool isAddUpiSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Payment Method'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios,
                size: Dimensions.defaultPadding),
          )),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 144,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < paymentOptions.length; i++)
                    GestureDetector(
                      onTap: () => i == 2
                          ? Get.toNamed(ParentPayLaterScreen.routeName)
                          : setState(() {
                              selectedIndex = i;
                            }),
                      child: paymentMethodCard(
                          index: i,
                          name: paymentOptions[i],
                          isSelected: selectedIndex == i),
                    )
                ],
              ),
            ),
          ),
          if (selectedIndex == 0) ...[
            const SizedBox(height: 64),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // *
                ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                        width: 1, color: AppColors.cardBorderColor),
                  ),
                  leading: Container(
                    width: 36,
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: AppColors.cardBorderColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: SvgPicture.asset(AssetsConstants.mastercard),
                  ),
                  title: Text(
                    "Ending ***720",
                    style: kDark_14_500,
                  ),
                  subtitle: Text(
                    "Exp: 02-23",
                    style: kSecondary_14_400,
                  ),
                  trailing: Radio(
                    activeColor: AppColors.primaryColor,
                    value: true,
                    groupValue: isCardSelected,
                    toggleable: true,
                    onChanged: (_) => setState(() {
                      isCardSelected = !isCardSelected;
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Get.toNamed(ParentCardAddScreen.routeName),
                  child: ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: AppColors.cardBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    leading: Container(
                      width: 36,
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFE9E9E9)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Icon(Icons.add, size: 15),
                    ),
                    title: Text(
                      "Add New Card",
                      style: kDark_14_500,
                    ),
                    subtitle: Text(
                      "Save and Pay via Cards",
                      style: kSecondary_14_400,
                    ),
                  ),
                )
              ],
            ),
          ],
          if (selectedIndex == 1) ...[
            const SizedBox(height: 20),
            Text(
              'Pay by any UPI APP',
              style: kSecondary_12_400,
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < upiIcons.length; i++)
                    GestureDetector(
                      onTap: () => setState(() {
                        if (i == 3) isAddUpiSelected = !isAddUpiSelected;
                      }),
                      child: Container(
                        width: 75.w,
                        height: 97.h,
                        margin: EdgeInsets.only(right: i != 3 ? 20 : 0),
                        padding: const EdgeInsets.all(8),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2,
                                  color: isAddUpiSelected && i == 3
                                      ? AppColors.primaryColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              upiIcons[i],
                              colorBlendMode: BlendMode.lighten,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              upiTitles[i],
                              style: kDark_12_500,
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(height: 39),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(
                    width: 1, color: AppColors.cardBorderColor),
              ),
              leading: Container(
                width: 36,
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 1, color: AppColors.cardBorderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Image.network(upiIcons[3]),
              ),
              title: Text(
                "***********@ybl",
                style: kDark_14_500,
              ),
              trailing: Radio(
                activeColor: AppColors.primaryColor,
                value: true,
                groupValue: isUpiSelected,
                toggleable: true,
                onChanged: (_) => setState(() {
                  isUpiSelected = !isUpiSelected;
                }),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => setState(() {
                isAddUpiSelected = !isAddUpiSelected;
              }),
              child: ListTile(
                minTileHeight: 48,
                tileColor: const Color(0xFFD5DAE7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      topRight: const Radius.circular(5),
                      bottomLeft: Radius.circular(isAddUpiSelected ? 0 : 5),
                      bottomRight: Radius.circular(isAddUpiSelected ? 0 : 5)),
                  side: const BorderSide(
                      width: 1, color: AppColors.cardBorderColor),
                ),
                leading: Container(
                  width: 36,
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1, color: AppColors.cardBorderColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Image.network(upiIcons[3]),
                ),
                title: Text(
                  "Add a new UPI ID",
                  style: kDark_14_500,
                ),
                trailing: const Icon(Icons.add),
              ),
            ),
            ...[
              isAddUpiSelected
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 52,
                          width: double.infinity,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppColors.cardBorderColor),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Enter Your UPI ID",
                            style: kDark_12_500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Your UPI ID will be encrypted and is safe with us',
                          style: TextStyle(
                            color: Color(0xFF83898F),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 13),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.accentColor,
                                fixedSize: Size(Get.width - 32, 48),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {},
                            child: const Text(
                              "Add UPI ID",
                            )),
                      ],
                    )
                  : const SizedBox(),
            ],
          ],
          const Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  fixedSize: Size(Get.width - 32, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: isCardSelected || isUpiSelected ? () {} : null,
              child: const Text(
                "Continue",
              )),
        ]),
      ),
    );
  }

  Container paymentMethodCard({
    required int index,
    required String name,
    required bool isSelected,
  }) {
    return Container(
      width: 126,
      margin: EdgeInsets.only(right: index == 2 ? 0 : 16),
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsConstants.card,
            colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : AppColors.selectedItemColor,
                BlendMode.srcIn),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 32,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: isSelected ? kLight_12_500 : kDark_12_500,
            ),
          ),
        ],
      ),
    );
  }
}
