import 'package:equatable/equatable.dart';

import '../../../domain/entities/schedule.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleEmpty extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}

class ScheduleHasData extends ScheduleState {
  final Schedule result;

  const ScheduleHasData(this.result);

  @override
  List<Object> get props => [result];
}
