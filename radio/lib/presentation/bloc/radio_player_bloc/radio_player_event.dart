import 'package:equatable/equatable.dart';

abstract class RadioPlayerEvent extends Equatable {
  const RadioPlayerEvent();
}

class OnPlayRadio extends RadioPlayerEvent {
  const OnPlayRadio();

  @override
  List<Object> get props => [];
}

class OnStopRadio extends RadioPlayerEvent {
  const OnStopRadio();

  @override
  List<Object> get props => [];
}
