import 'package:cloud_firestore/cloud_firestore.dart';

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

  String displayDate(int index, QuerySnapshot querySnapshot) {
    var doc = querySnapshot.docs;
    var startDay = doc[index].get('startDate').toDate().day;
    var endDay = doc[index].get('endDate').toDate().day;
    String month = getMonthName(doc[index].get('startDate').toDate().month);

    String date = '$month $startDay - $endDay';
    return date;
  }
}
