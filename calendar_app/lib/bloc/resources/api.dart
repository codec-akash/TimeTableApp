import 'package:calendarapp/models/event.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';

class ApiProvider {
  Client client = Client();

  Future<List<Event>> getUserEvent() async {
    final response = await client.get("http://10.0.2.2:5000/events");
    final Map result = json.decode(response.body);
    print(result['events'].toString());
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<Event> events = [];
      for (Map json_ in result["events"]) {
        print(json_.toString());
        print("hello");
        try {
          Event event = Event.fromJson(json_);
          events.add(event);
        } catch (Exception) {
          print(Exception);
        }
      }
      for (Event event_ in events) {
        print(event_.title);
      }
      return events;
    } else {
      throw Exception('Failed To Load Post');
    }
  }
}
