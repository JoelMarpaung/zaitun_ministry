import 'package:core/constants/enums.dart';
import 'package:equatable/equatable.dart';

class SocialMedia extends Equatable {
  final SocialMediaType type;
  final String url;
  final String title;

  const SocialMedia({required this.type, required this.url, required this.title});

  @override
  List<Object> get props => [type, url, title];
}