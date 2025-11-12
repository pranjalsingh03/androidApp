import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';

jsonPrint(String title, dynamic body) {
  if (!kDebugMode) return;
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String requestBody = encoder.convert(body);
  log("--------------- $title ---------------");
  log(requestBody);
}
