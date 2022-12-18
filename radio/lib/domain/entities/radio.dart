import 'package:equatable/equatable.dart';

class Radio extends Equatable {
  final String url;

  const Radio({required this.url});

  @override
  List<Object?> get props => [url];
}
