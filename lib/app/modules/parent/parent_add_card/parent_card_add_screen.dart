import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/ui_constants_old.dart';

class ParentCardAddScreen extends StatefulWidget {
  static const routeName = "/parent-add-card";
  const ParentCardAddScreen({super.key});

  @override
  State<ParentCardAddScreen> createState() => _ParentCardAddScreenState();
}

class _ParentCardAddScreenState extends State<ParentCardAddScreen> {
  bool isSaveCardSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add a card'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
          )),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            inputField(placeholder: "Card Holder Name"),
            inputField(placeholder: "Credit/Debit Card number"),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: inputField(
                      placeholder: "Expired date", width: (Get.width - 64) / 2),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: inputField(
                        placeholder: "CVV", width: (Get.width - 64) / 2)),
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: AppColors.primaryColor,
                  value: true,
                  groupValue: isSaveCardSelected,
                  toggleable: true,
                  onChanged: (_) => setState(() {
                    isSaveCardSelected = !isSaveCardSelected;
                  }),
                ),
                const Text(
                  'Securely Save this card',
                  style: TextStyle(
                    color: Color(0xFF1B1446),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
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
                onPressed: isSaveCardSelected ? () {} : null,
                child: const Text(
                  "Continue",
                )),
          ],
        ),
      ),
    );
  }

  Container inputField(
      {required String placeholder, double width = double.infinity}) {
    return Container(
      height: 58,
      width: width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.cardBorderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        shadows: UiConstants.defaultBoxShadows,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            placeholder,
            style: const TextStyle(
              color: AppColors.unSelectedItemColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
