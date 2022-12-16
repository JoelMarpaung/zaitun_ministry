import 'package:equatable/equatable.dart';


abstract class RadioPlayerState extends Equatable {
  const RadioPlayerState();

  @override
  List<Object> get props => [];
}

class RadioPlayerEmpty extends RadioPlayerState {}

class RadioPlayerLoading extends RadioPlayerState {}

class RadioPlayerPlay extends RadioPlayerState {}

class RadioPlayerStop extends RadioPlayerState {}

class RadioPlayerError extends RadioPlayerState {
  final String message;

  const RadioPlayerError(this.message);

  @override
  List<Object> get props => [message];
}
