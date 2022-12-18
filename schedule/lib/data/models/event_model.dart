import 'package:equatable/equatable.dart';

import '../../domain/entities/event.dart';

class EventModel extends Equatable {
  final String startTime;
  final String endTime;
  final String name;
  final List<String> presenters;

  EventModel({required this.startTime, required this.endTime, required this.name, required this.presenters});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      startTime: json['start_time'],
      endTime: json['end_time'],
      name: json['acara'],
      presenters: List<String>.from(json['penyiar']),
    );
  }

  Event toEntity() {
    return Event(
      startTime: startTime,
      endTime: endTime,
      name: name,
      presenters: presenters,
    );
  }

  @override
  List<Object> get props => [startTime, endTime, name, presenters];
}