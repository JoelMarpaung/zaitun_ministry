import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_data_schedule.dart';
import 'schedule_data_event.dart';
import 'schedule_data_state.dart';

class ScheduleDataBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetDataSchedule _dataSchedule;

  ScheduleDataBloc(this._dataSchedule) : super(ScheduleEmpty()) {
    on<OnFetchDataSchedule>((event, emit) async {
      emit(ScheduleLoading());
      final result = await _dataSchedule.execute();
      result.fold(
        (failure) async {
          emit(ScheduleError(failure.message));
        },
        (data) async {
          emit(ScheduleHasData(data));
        },
      );
    });
  }
}
