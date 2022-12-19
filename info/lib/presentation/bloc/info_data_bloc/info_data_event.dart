import 'package:equatable/equatable.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();
}

class OnFetchDataInfo extends InfoEvent {
  const OnFetchDataInfo();

  @override
  List<Object> get props => [];
}
