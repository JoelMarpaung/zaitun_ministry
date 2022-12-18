import 'package:equatable/equatable.dart';
import 'event.dart';

class Schedule extends Equatable {
  final Map<String, List<Event>> events;

  Schedule({required this.events});

  @override
  List<Object> get props => [events];
}