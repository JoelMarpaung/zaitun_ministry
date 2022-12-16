import 'package:equatable/equatable.dart';

import '../../../domain/entities/radio.dart';

abstract class RadioState extends Equatable {
  const RadioState();

  @override
  List<Object> get props => [];
}

class RadioEmpty extends RadioState {}

class RadioLoading extends RadioState {}

class RadioComplete extends RadioState {}

class RadioError extends RadioState {
  final String message;

  const RadioError(this.message);

  @override
  List<Object> get props => [message];
}

class RadioHasData extends RadioState {
  final Radio result;

  const RadioHasData(this.result);

  @override
  List<Object> get props => [result];
}
