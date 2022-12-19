
import 'package:core/constants/enums.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/social_media.dart';

class SocialMediaModel extends Equatable {
  final SocialMediaType type;
  final String url;
  final String title;

  const SocialMediaModel({required this.type, required this.url, required this.title});

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      type: _parseType(json['type']),
      url: json['url'],
      title: json['title'],
    );
  }

  static SocialMediaType _parseType(String type) {
    switch (type) {
      case 'youtube':
        return SocialMediaType.youtube;
      case 'facebook':
        return SocialMediaType.facebook;
      case 'instagram':
        return SocialMediaType.instagram;
      default:
        throw Exception('Invalid social media type');
    }
  }

  SocialMedia toEntity() {
    return SocialMedia(
      type: type,
      url: url,
      title: title,
    );
  }

  @override
  List<Object> get props => [type, url, title];
}