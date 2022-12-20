import 'package:core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/social_media.dart';

class SocialMediaTile extends StatelessWidget {
  final SocialMedia model;

  const SocialMediaTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(model.url);
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        color: Colors.lightBlue.shade900,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIcon(model.type),
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                model.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(SocialMediaType type) {
    switch (type) {
      case SocialMediaType.youtube:
        return FontAwesomeIcons.youtube;
      case SocialMediaType.facebook:
        return FontAwesomeIcons.facebook;
      case SocialMediaType.instagram:
        return FontAwesomeIcons.instagram;
      default:
        throw Exception('Invalid social media type');
    }
  }
}