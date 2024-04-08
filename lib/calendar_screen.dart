import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  final DateTime firstDay;

  CalendarScreen({required this.firstDay});

  @override
  Widget build(BuildContext context) {
    DateTime lastDay = firstDay.add(Duration(days: 28));
    DateTime currentDate = DateTime.now();
    int daysUntilNextPeriod = lastDay.difference(currentDate).inDays;

    return Scaffold(
      appBar: AppBar(
        title: Text('Menstrual Cycle Predictor'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: firstDay,
            calendarStyle: CalendarStyle(
              // Highlighting the first 7 days and the last day
              rangeEndDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              rangeStartDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              rangeEndTextStyle: TextStyle(color: Colors.white),
              rangeStartTextStyle: TextStyle(color: Colors.white),
              // Ensure all days have the same text style
              defaultTextStyle: TextStyle(color: Colors.black),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(day, firstDay) ||
                  isSameDay(day, lastDay) ||
                  day.isAfter(firstDay) && day.isBefore(firstDay.add(Duration(days: 7)));
            },
            // Indicate the current day
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                if (isSameDay(date, currentDate)) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return Text(date.day.toString());
                }
              },
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Days until next period: $daysUntilNextPeriod',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
