import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeService {
  String getMonthName(int monthNumber) {
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[
        monthNumber - 1]; // Adjust index since month numbers start from 1
  }

  String votingTime(DateTime start, DateTime end) {
    DateTime startDate = start;
    DateTime endDate = end;

    ///
    String starMonth = getMonthName(startDate.month);
    String endMonth = getMonthName(endDate.month);

    String date = '${startDate.day} $starMonth  - ${endDate.day} $endMonth';
    return date;
  }

  //////
  String getFormatedDate(Timestamp timestamp) {
    // Convert timestamp to DateTime

    // Define the format you want
    DateFormat dateFormat = DateFormat('dd/MM/yyyy h:mm a');

    // Format the DateTime and return the formatted string
    return dateFormat.format(timestamp.toDate());
  }

  String getOnlyDate(Timestamp timestamp) {
    // Convert timestamp to DateTime

    // Define the format you want
    DateFormat dateFormat = DateFormat('dd/MM/yyyy ');

    // Format the DateTime and return the formatted string
    return dateFormat.format(timestamp.toDate());
  }

  ///////
  Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      anchorPoint: Offset(10, 15),
      // cancelText: 'Cancel',
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    return selectedDate;
  }

  Timestamp convertToTimestamp(DateTime dateTime) {
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    print(timestamp);
    return timestamp;
  }

  // Get difference //

  int getDifference(DateTime start, DateTime end) {
    Duration difference = end.difference(start);

    int days = difference.inDays;
    return days;
  }
}
