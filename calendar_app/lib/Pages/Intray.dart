import 'package:calendarapp/bloc/blocs/user_bloc_provider.dart';
import 'package:calendarapp/models/Widget/IntrayEvents.dart';
import 'package:calendarapp/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntrayWidget extends StatefulWidget {
  @override
  _IntrayWidgetState createState() => _IntrayWidgetState();
}

class _IntrayWidgetState extends State<IntrayWidget> {
  List<Event> eventList = [];
  EventBloc eventBloc;

  @override
  void initState() {
    // TODO: implement initState
    eventBloc = EventBloc();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: eventBloc.getEvent,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot != null) {
            if (snapshot.data.length > 0) {
              return _buildReorderableListSimple(context, snapshot.data);
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text("Error"),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context, Event item) {
    return ListTile(
      key: Key(item.id.toString()),
      title: IntrayEvent(
        title: item.title,
        start: item.startTime,
      ),
    );
  }

  Widget _buildReorderableListSimple(
      BuildContext context, List<Event> eventList) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: ReorderableListView(
        padding: EdgeInsets.only(top: 30),
        children: eventList
            .map((Event item) => _buildListTile(context, item))
            .toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Event item = eventList[oldIndex];
            eventList.remove(item);
            eventList.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
