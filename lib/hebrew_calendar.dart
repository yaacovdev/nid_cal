import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';

class HebrewCalendar extends StatefulWidget {
  const HebrewCalendar({Key? key}) : super(key: key);

  @override
  State<HebrewCalendar> createState() => _HebrewCalendarState();
}

class _HebrewCalendarState extends State<HebrewCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  JewishDate jewishDate = JewishDate();
  JewishCalendar jewishCalendar = JewishCalendar();
  HebrewDateFormatter hebrewDateFormatter = HebrewDateFormatter()
    ..hebrewFormat = true;

  @override
  void initState() {
    super.initState();
  }

  String _getHebrewDate(DateTime date) {
    jewishDate.setDate(date);
    return hebrewDateFormatter.format(jewishDate, pattern: 'dd, MM');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nid Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        _getHebrewDate(date),
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
              selectedBuilder: (context, date, _) {
                return Container(
                  margin: EdgeInsets.all(1.w),
                  padding: EdgeInsets.all(0.5.w),
                  color: Colors.purple[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Text(
                        _getHebrewDate(date),
                        style: TextStyle(fontSize: 11, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            _selectedDay != null
                ? 'Selected day: ${_selectedDay!.toLocal()}'
                : 'No day selected',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            _selectedDay != null
                ? 'Hebrew date: ${_getHebrewDate(_selectedDay!)}'
                : '',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
