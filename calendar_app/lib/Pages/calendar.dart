import 'package:calendarapp/Pages/Intray.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalender extends StatefulWidget {
  @override
  _MyCalenderState createState() => _MyCalenderState();
}

class _MyCalenderState extends State<MyCalender> {
  CalendarController _calendarController;
  List<dynamic> _listedEvents;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventTextController;

  TimeOfDay _endTime;
  TimeOfDay _startTime;
  String _startTimeText;
  String _endTimeText;
  int yearSelected;
  int monthSelected;
  int daySelected;
  String selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    _calendarController = CalendarController();
    _eventTextController = TextEditingController();
    _events = {};
    _listedEvents = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TableCalendar(
            calendarController: _calendarController,
            events: _events,
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.twoWeeks,
            onDaySelected: (date, events) {
              setState(() {
                _listedEvents = events;
              });
            },
            calendarStyle: CalendarStyle(
              selectedColor: Colors.deepOrange[400],
              todayColor: Colors.deepOrange[200],
              markersColor: Colors.brown[700],
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonTextStyle:
                  TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
              formatButtonDecoration: BoxDecoration(
                color: Colors.deepOrange[400],
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            height: MediaQuery.of(context).size.width * 0.12,
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                _addingEvents();
                yearSelected = _calendarController.selectedDay.year;
                monthSelected = _calendarController.selectedDay.month;
                daySelected = _calendarController.selectedDay.day;
                selectedDate =
                    formatDate(yearSelected, monthSelected, daySelected);
                print(selectedDate);
              },
              color: Colors.deepOrange[400],
              child: Text(
                "Add Events",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text("Listed Events"),
          ..._listedEvents.map((e) => ListTile(
                title: Text(e),
              )),
          IntrayWidget(),
        ],
      ),
    );
  }

  _addingEvents() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 15.0, top: 5.0, right: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextField(
                    controller: _eventTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        hintText: "Enter Events"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  RaisedButton(
                    color: Colors.deepOrange[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Text(
                      _startTimeText == null
                          ? "Start Time"
                          : _startTime.hour.toString() +
                              " : " +
                              ((_startTime.minute < 9)
                                  ? "0" + _startTime.minute.toString()
                                  : _startTime.minute.toString()),
                    ),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        setState(() {
                          _startTime = value;
                          _startTimeText = _startTime.hour.toString() +
                              ((_startTime.minute < 9)
                                  ? "0" + _startTime.minute.toString()
                                  : _startTime.minute.toString());
                          print({_startTime, _startTimeText});
                        });
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.deepOrange[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Text(
                      _endTime == null
                          ? "End Time"
                          : _endTime.hour.toString() +
                              " : " +
                              ((_startTime.minute < 9)
                                  ? "0" + _startTime.minute.toString()
                                  : _startTime.minute.toString()),
                    ),
                    onPressed: () {
                      if (_startTime == null) {
                        Toast.show("Select Start time first", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      } else {
                        showTimePicker(
                                context: context, initialTime: _startTime)
                            .then((value) {
                          setState(() {
                            _endTime = value;
                            if (value
                                    .toString()
                                    .compareTo(_startTime.toString()) <
                                0) {
                              _endTime = null;
                              Toast.show(
                                  "Select Time after Starting Time", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            } else {
                              _endTimeText = _endTime.hour.toString() +
                                  ((_startTime.minute < 9)
                                      ? "0" + _startTime.minute.toString()
                                      : _startTime.minute.toString());
                              print({_endTime, _endTimeText});
                            }
                          });
                        });
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          _eventTextController.clear();
                          Navigator.pop(context);
                          setState(() {
                            _endTime = null;
                            _startTime = null;
                            _startTimeText = null;
                            _endTimeText = null;
                          });
                        },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                      FlatButton(
                        child: Text("Save"),
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        onPressed: () {
                          if (_eventTextController.text.isEmpty) return;
                          setState(() {
                            if (_events[_calendarController.selectedDay] !=
                                null) {
                              _events[_calendarController.selectedDay]
                                  .add(_eventTextController.text);
                            } else {
                              _events[_calendarController.selectedDay] = [
                                _eventTextController.text
                              ];
                            }
                            _eventTextController.clear();
                            Navigator.pop(context);
                            setState(() {
                              _endTime = null;
                              _startTime = null;
                              _startTimeText = null;
                              _endTimeText = null;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //Date to Format
  String formatDate(int year, int month, int day) {
    String y;
    String m;
    String d;
    y = year.toString();
    m = month < 9 ? "0" + month.toString() : month.toString();
    d = day < 9 ? "0" + day.toString() : day.toString();
    String date = y + m + d;
    print("Selected Date $date");
    return date;
  }
}
