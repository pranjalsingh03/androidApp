// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:sheshya/app/modules/parent/parent_fees_tuition/payment_error.dart';
// import 'package:sheshya/app/modules/parent/parent_fees_tuition/payment_success.dart';
// import 'dart:convert';
// import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';
// import 'package:sheshya/components/custom_snackbar_widget.dart';
// import 'package:sheshya/helper/custom_print.dart';
// import 'fee_card.dart';

// class ParentTutionFeeScreen extends StatefulWidget {
//   static const routeName = "/parent-tuition-fee";

//   const ParentTutionFeeScreen({super.key});

//   @override
//   _ParentTutionFeeScreenState createState() => _ParentTutionFeeScreenState();
// }

// class _ParentTutionFeeScreenState extends State<ParentTutionFeeScreen> {
//   late Razorpay _razorpay;
//   final ParentHomeController controller = Get.put(ParentHomeController());

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();

//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

// Future<void> openPaymentPortal(int amount, String month) async {

//     String orderId = await controller.createOrder(amount, month);
//     if (orderId== null) {
//       showCustomSnackBar("Failed to create order", type: SnackBarType.error);
//       return;
//     }
//   try {

//     controller.currentOrderId = orderId;
//     controller.currentAmount = amount;
//     controller.currentMonth = month;

//     var options = {
//       'key': 'rzp_live_CnH92bWDDJBGLf',
//       'amount': amount * 100,
//       'order_id': orderId,
//       'name': controller.studentProfileResModel?.data?.academic?.schoolName,
//       'description': 'Tuition Fee for $month',
//       'prefill': {
//         'contact': controller.studentProfileResModel?.data?.basic?.phoneNo,
//         'name': controller.studentProfileResModel?.data?.basic?.name,
//         'email': controller.studentProfileResModel?.data?.basic?.email,
//       },
//       'theme': {'color': '#3399cc'},
//     };

//     _razorpay.open(options);
//   } catch (e) {
//     debugPrint('Error: $e');
//     Get.snackbar("Error", "Failed to initiate payment",
//         backgroundColor: Colors.red, colorText: Colors.white);
//   } finally {
//     controller.isLoading.value = false;
//   }
// }




// void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   customPrint(response);
//   showCustomSnackBar("Payment Successful", type: SnackBarType.success);
//   debugPrint("Payment Success: ${response.paymentId}");

//   final orderId = controller.currentOrderId;
//   final amount = controller.currentAmount;
//   final month = controller.currentMonth;

//   if (orderId != null && amount != null && month != null) {
//     controller.updatePaymentStatus(
//       orderId,
//       response.paymentId!,
//       amount,
//       month,
//       "success"
//     );
//     Get.to(() => PaymentSuccessPage(
//       paymentId: response.paymentId!,
//       amount: amount,
//       month: month,
//     ));
//   } else {
//     debugPrint("Error: Missing order/payment details");
//   }
// }


//   void _handlePaymentError(PaymentFailureResponse response) {
//     showCustomSnackBar("Payment Failed", type: SnackBarType.error);
//   final amount = controller.currentAmount;
//   final month = controller.currentMonth;
//     Get.to(()=>{
//       PaymentFailedPage(
//         error: response.message ?? "Somenthing went wrong",
//         amount: amount ?? 0,
//         month: month??" ",
//       )
//     });
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     showCustomSnackBar("External Wallet: ${response.walletName}",
//         type: SnackBarType.info);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Text('Tuition Fees'),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GetBuilder<ParentHomeController>(
//                 builder: (controller) {
//                   final dues = controller.dues.asMap().entries.toList();
//                   return Column(
//                     children: dues.map((entry) {
//                       return GestureDetector(
//                         onTap: () => openPaymentPortal(entry.value.amount, entry.value.month),
//                         child: FeeCard(
//                           title: entry.key == 0
//                               ? "PAYMENT DUE - ${entry.value.month.toUpperCase()}"
//                               : "NEXT PAYMENT DUE - ${entry.value.month.toUpperCase()}",
//                           amount: entry.value.amount.toString(),
//                           isDue: entry.key == 0,
//                           onTap: () => openPaymentPortal(entry.value.amount, entry.value.month),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),

//               const SizedBox(height: 16),
//               const Center(child: Icon(Icons.keyboard_arrow_down, size: 32)),

//               const SizedBox(height: 16),
//               const Text("Last Payments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

//               // **Last Payments Section**
//               GetBuilder<ParentHomeController>(
//                 builder: (controller) {
//                   return Column(
//                     children: controller.pastPayments.map((payment) {
//                       return GestureDetector(
//                         onTap: () {},
//                         child: FeeCard(
//                           title: "PAID - ${payment.month.toUpperCase()}",
//                           amount: payment.amount.toString(),
//                           isDue: false,
//                           onTap: () {},
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
