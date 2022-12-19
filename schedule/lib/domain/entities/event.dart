import 'package:equatable/equatable.dart';
class Event extends Equatable {
  final String startTime;
  final String endTime;
  final String name;
  final List<String> presenters;

  const Event({required this.startTime, required this.endTime, required this.name, required this.presenters});

  @override
  List<Object> get props => [startTime, endTime, name, presenters];
}