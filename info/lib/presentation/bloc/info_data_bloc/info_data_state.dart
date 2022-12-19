import 'package:equatable/equatable.dart';

import '../../../domain/entities/info.dart';

abstract class InfoState extends Equatable {
  const InfoState();

  @override
  List<Object> get props => [];
}

class InfoEmpty extends InfoState {}

class InfoLoading extends InfoState {}

class InfoError extends InfoState {
  final String message;

  const InfoError(this.message);

  @override
  List<Object> get props => [message];
}

class InfoHasData extends InfoState {
  final Info result;

  const InfoHasData(this.result);

  @override
  List<Object> get props => [result];
}
