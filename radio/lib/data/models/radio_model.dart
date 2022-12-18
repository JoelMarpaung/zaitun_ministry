import 'package:equatable/equatable.dart';

import '../../domain/entities/radio.dart';

class RadioModel extends Equatable {
  final String url;

  const RadioModel({required this.url});

  factory RadioModel.fromJson(Map<String, dynamic> json) => RadioModel(
        url: json["url"],
      );

  Radio toEntity() {
    return Radio(url: url);
  }

  @override
  List<Object?> get props => [url];
}
