import 'dart:async';
import 'package:calendarapp/bloc/resources/api.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future getUserEvent() => apiProvider.getUserEvent();
}