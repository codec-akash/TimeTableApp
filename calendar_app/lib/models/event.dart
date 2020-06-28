class Event {
  String id;
  List<Event> events;
  String title;
  String date;
  String startTime;
  String endTime;

  Event(this.title, this.date, this.startTime, this.endTime);

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return Event(parsedJson['title'], parsedJson['date'],
        parsedJson['start_time'], parsedJson['end_time']);
  }
}
