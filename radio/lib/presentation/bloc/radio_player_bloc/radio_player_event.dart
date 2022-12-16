import 'package:equatable/equatable.dart';

abstract class RadioPlayerEvent extends Equatable {
  const RadioPlayerEvent();
}

class OnPlayRadio extends RadioPlayerEvent {
  final String url;
  const OnPlayRadio(this.url);

  @override
  List<Object> get props => [];
}

class OnStopRadio extends RadioPlayerEvent {
  const OnStopRadio();

  @override
  List<Object> get props => [];
}
