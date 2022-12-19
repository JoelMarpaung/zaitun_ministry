import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_data_info.dart';
import 'info_data_event.dart';
import 'info_data_state.dart';

class InfoDataBloc extends Bloc<InfoEvent, InfoState> {
  final GetDataInfo _dataInfo;

  InfoDataBloc(this._dataInfo) : super(InfoEmpty()) {
    on<OnFetchDataInfo>((event, emit) async {
      emit(InfoLoading());
      final result = await _dataInfo.execute();
      result.fold(
        (failure) async {
          emit(InfoError(failure.message));
        },
        (data) async {
          emit(InfoHasData(data));
        },
      );
    });
  }
}
