import 'package:equatable/equatable.dart';
import 'package:info/data/models/social_media_model.dart';

import '../../domain/entities/info.dart';

class InfoModel extends Equatable {
  final String address;
  final String description;
  final String latitude;
  final String longitude;
  final String googleMap;
  final List<SocialMediaModel> socialMedia;

  const InfoModel({required this.address, required this.description, required this.latitude, required this.longitude, required this.googleMap, required this.socialMedia});

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      address: json['alamat_radio'],
      description: json['deskripsi'],
      latitude: json['latitude_map'],
      longitude: json['longitude_map'],
      googleMap: json['google_map'],
      socialMedia: List<SocialMediaModel>.from(json['social_media'].map((x) => SocialMediaModel.fromJson(x))),
    );
  }

  Info toEntity() {
    return Info(
      address: address,
      description: description,
      latitude: latitude,
      longitude: longitude,
      googleMap: googleMap,
      socialMedia: socialMedia.map((x) => x.toEntity()).toList(),
    );
  }

  @override
  List<Object> get props => [address, description, latitude, longitude, googleMap, socialMedia];
}