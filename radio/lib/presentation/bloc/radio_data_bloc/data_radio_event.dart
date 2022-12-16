import 'package:equatable/equatable.dart';

abstract class RadioEvent extends Equatable {
  const RadioEvent();
}

class OnFetchDataRadio extends RadioEvent {
  const OnFetchDataRadio();

  @override
  List<Object> get props => [];
}
