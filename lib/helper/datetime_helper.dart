// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

class DateTimeHelper {
  static String ddmmyyyy({required String? date}) {
    if (date == null || date.isEmpty) return "null";

    try {
      // If it's a numeric string like "37861"
      final serial = int.tryParse(date);
      if (serial != null) {
        final converted = DateTime(1899, 12, 30).add(Duration(days: serial));
        return DateFormat('dd-MM-yyyy').format(converted);
      }

      // If it's already a valid ISO string (e.g. "2024-05-07")
      final parsedDate = DateTime.tryParse(date);
      if (parsedDate != null) {
        return DateFormat('dd-MM-yyyy').format(parsedDate);
      }

      // If parsing fails
      return "null";
    } catch (e) {
      return "null";
    }
  }

  static String yyyymmdd({required String date}) {
    try {
      DateTime parsedDate;
      if (isNumeric(date)) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      } else {
        parsedDate = DateFormat('dd-MM-yyyy').parse(date);
      }
      return DateFormat('yyyy/MM/dd').format(parsedDate);
    } catch (e) {
      throw FormatException("Invalid date format: $date");
    }
  }

  static String yyyy_mm_dd({required String date}) {
    try {
      DateTime parsedDate;
      if (isNumeric(date)) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      } else {
        parsedDate = DateFormat('dd-MM-yyyy').parse(date);
      }
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      throw FormatException("Invalid date format: $date");
    }
  }

  static String ddMMMMyyyy({required String date}) {
    try {
      DateTime parsedDate;
      if (isNumeric(date)) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      } else {
        parsedDate = DateFormat('dd-MM-yyyy').parse(date);
      }
      return DateFormat('dd MMMM yyyy').format(parsedDate);
    } catch (e) {
      throw FormatException("Invalid date format: $date");
    }
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static String defaultdate({required String date}) {
    try {
      DateTime parsedDate;
      if (isNumeric(date)) {
        parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
      } else {
        parsedDate = DateFormat('dd-MM-yyyy').parse(date);
      }
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      throw FormatException("Invalid date format: $date");
    }
  }
}
