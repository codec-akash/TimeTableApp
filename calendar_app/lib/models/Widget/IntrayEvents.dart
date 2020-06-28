import 'package:flutter/material.dart';

class IntrayEvent extends StatelessWidget {
  final String title;
  final String start;
  final String keyValue;
  IntrayEvent({this.title, this.start, this.keyValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyValue),
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            new BoxShadow(
              color: Colors.black.withOpacity(0.5),
            ),
          ]),
      child: Row(
        children: <Widget>[
          Radio(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(title),
                Text(start),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
