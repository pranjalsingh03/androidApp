// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PaymentScreen extends StatefulWidget {
//   static const routeName = "/payment-screen";
//   final double amount;
//   final String month;

//   PaymentScreen({required this.amount, required this.month, super.key});

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();

//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

//     // Fetch order details after the widget is built
//     Future.delayed(Duration.zero, _createOrder);
//   }

//   Future<void> _createOrder() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final url = Uri.parse(
//         'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/finance/createRazorPayOrderId');
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'amount': (widget.amount * 100).toInt(), // Convert to paise
//           'currency': 'INR',
//           'month': widget.month,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         if (responseData['data'] != null &&
//             responseData['data']['orderId'] != null) {
//           _startPayment(responseData['data']['orderId']);
//         } else {
//           _showSnackBar("Invalid order response");
//         }
//       } else {
//         _showSnackBar("Order creation failed: ${response.body}");
//       }
//     } catch (e) {
//       _showSnackBar("Error creating order: $e");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void _startPayment(String orderId) {
//     var options = {
//       'key': 'rzp_test_nGfzkD8lnLLSBu', // Replace with your Razorpay key
//       'amount': (widget.amount * 100).toInt(), // Convert to paise
//       'currency': 'INR',
//       'name': 'School Fees Payment',
//       'description': 'Paying school fees directly to the school',
//       'order_id': orderId,
//       'prefill': {
//         'contact': '9876543210',
//         'email': 'student@example.com',
//       },
//       'theme': {
//         'color': '#3399cc',
//       },
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       _showSnackBar("Error starting payment: $e");
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     final verifyUrl = Uri.parse(
//         'https://sheshya-backend-deployed-529940359558.asia-south1.run.app/finance/verifyPayment');
//     try {
//       final verifyResponse = await http.post(
//         verifyUrl,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'orderId': response.orderId,
//           'paymentId': response.paymentId,
//           'paymentSignature': response.signature,
//         }),
//       );

//       final verifyResult = jsonDecode(verifyResponse.body);
//       if (verifyResult['success']) {
//         _showSnackBar("Payment verified successfully!");
//       } else {
//         _showSnackBar("Payment verification failed!");
//       }
//     } catch (e) {
//       _showSnackBar("Error verifying payment: $e");
//     }
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     _showSnackBar("Payment failed: ${response.message}");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _showSnackBar("External wallet selected: ${response.walletName}");
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   void dispose() {
//     _razorpay.clear(); // Clear all event listeners
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Make Payment")),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Center(child: const Text("Processing Payment...")),
//     );
//   }
// }