import 'package:calendarapp/bloc/resources/repository.dart';
import 'package:calendarapp/models/event.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc{
  final _repository = Repository();
  final _eventSubject = BehaviorSubject<List<Event>>();

  var _event = <Event>[];

  EventBloc(){
    _updateEvents().then((_) {
      _eventSubject.add(_event);
    });
  }

  Stream<List<Event>> get getEvent => _eventSubject.stream;

  Future<Null> _updateEvents() async {
    _event = await _repository.getUserEvent();
  }
}