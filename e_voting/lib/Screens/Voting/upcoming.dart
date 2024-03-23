import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class UpcomingElection extends StatefulWidget {
  const UpcomingElection({super.key});

  @override
  State<UpcomingElection> createState() => _UpcomingElectionState();
}

class _UpcomingElectionState extends State<UpcomingElection> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTime> focusedDates = [
    DateTime(2024, 03, 18),
    DateTime(2024, 03, 25)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: Applayout.getheight(20)),
        child: Column(
          children: [
            //Calendar ////>>
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              //width: 79.w,
              width: Applayout.getWidth(300),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 12,
                        offset: Offset(0, 7))
                  ]),
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 16),
                lastDay: DateTime.utc(2025, 3, 14),
                focusedDay: _focusedDay,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                /////////////
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
                // calendarBuilders: CalendarBuilders(
                //   dowBuilder: (context, day) {
                //     final isFocused = focusedDates.contains(day);
                //     final color = isFocused
                //         ? Colors.lightBlue.withOpacity(0.3)
                //         : Colors.white; // Set style based on focus
                //     return Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //             color: isFocused
                //                 ? Colors.lightBlue
                //                 : Colors.transparent), // Add border for focus
                //       ),
                //       child: Center(child: Text(day.day.toString())),
                //     );
                //   },
                // ),
                calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                    selectedTextStyle: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    selectedDecoration: BoxDecoration(
                        border: Border.fromBorderSide(
                            BorderSide(color: Colors.green, width: 2)),
                        color: Colors.white,
                        shape: BoxShape.circle),
                    isTodayHighlighted: true,
                    todayDecoration: BoxDecoration(
                        color: AppStyle.primaryColor, shape: BoxShape.circle)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            //        2nd Section     //
            Container(
                // width: 75.w,
                width: Applayout.getWidth(300),
                height: Applayout.getheight(150),
                // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        left: BorderSide(
                            color: AppStyle.primaryColor, width: 15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Vote for University Counsil',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  subtitle: Text(
                    'June 17th - 8am to 10pm',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    // textAlign: TextAlign.center,
                  ),
                  trailing: PopupMenuButton(
                      offset: Offset(5, 0),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(child: Text('item1')),
                          PopupMenuItem(child: Text('item2')),
                        ];
                      }),
                )),

            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ]);
  }
}
