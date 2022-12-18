import 'package:equatable/equatable.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class OnFetchDataSchedule extends ScheduleEvent {
  const OnFetchDataSchedule();

  @override
  List<Object> get props => [];
}
