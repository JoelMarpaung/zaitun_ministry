import 'package:equatable/equatable.dart';
import 'package:info/domain/entities/social_media.dart';

class Info extends Equatable {
  final String address;
  final String description;
  final String latitude;
  final String longitude;
  final String googleMap;
  final List<SocialMedia> socialMedia;

  const Info({required this.address, required this.description, required this.latitude, required this.longitude, required this.googleMap, required this.socialMedia});

  @override
  List<Object> get props => [address, description, latitude, longitude, googleMap, socialMedia];
}