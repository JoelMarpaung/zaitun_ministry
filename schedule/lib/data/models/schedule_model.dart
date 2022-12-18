import 'package:equatable/equatable.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/schedule.dart';
import 'event_model.dart';
class ScheduleModel extends Equatable {
  final Map<String, List<EventModel>> events;

  ScheduleModel({required this.events});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<EventModel>> events = {};
    json.forEach((key, value) {
      events[key] = List<EventModel>.from(value.map((e) => EventModel.fromJson(e)));
    });
    return ScheduleModel(events: events);
  }

  Schedule toEntity() {
    Map<String, List<Event>> events = {};
    this.events.forEach((key, value) {
      events[key] = value.map((e) => e.toEntity()).toList();
    });
    return Schedule(events: events);
  }

  @override
  List<Object> get props => [events];
}