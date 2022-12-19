// ignore_for_file: library_private_types_in_public_api

import 'package:core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info/domain/entities/info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/social_media.dart';
import '../bloc/info_data_bloc/info_data_bloc.dart';
import '../bloc/info_data_bloc/info_data_event.dart';
import '../bloc/info_data_bloc/info_data_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoDataBloc, InfoState>(
      builder: (context, state) {
        if (state is InfoEmpty) {
          BlocProvider.of<InfoDataBloc>(context).add(const OnFetchDataInfo());
          return Stack(
            children: [
              const Center(
                child: CircularProgressIndicator(),
              ),
              topTitle()
            ],
          );
        } else if (state is InfoLoading) {
          return Stack(
            children: [
              const Center(
                child: CircularProgressIndicator(),
              ),
              topTitle()
            ],
          );
        } else if (state is InfoError) {
          return Stack(
            children: [
              Center(
                child: Text(state.message),
              ),
              topTitle()
            ],
          );
        } else if (state is InfoHasData) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 120),
                child: buildIListInfo(state.result),
              ),
              topTitle()
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget topTitle() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade900.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 1.0), //(x,y)
              blurRadius: 30.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Info Radio',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIListInfo(Info data) {
    return RefreshIndicator(
      onRefresh: () async {
        // Call the onFetchDataInfo event to refresh the data
        BlocProvider.of<InfoDataBloc>(context).add(const OnFetchDataInfo());
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.blue.shade700,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(data.address,
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(data.description,
                          style: GoogleFonts.roboto(
                              fontSize: 20, color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final latitude = data.latitude;
                          final longitude = data.longitude;
                          final Uri url = Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
                          if (!await launchUrl(url)) {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('Open Map'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Social Media',
                  style: GoogleFonts.righteous(fontSize: 30),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: data.socialMedia
                    .map((model) => SocialMediaTile(model: model))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaTile extends StatelessWidget {
  final SocialMedia model;

  const SocialMediaTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(model.url);
        if (!await launchUrl(url)) {
          throw 'Could not launch $url';
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        color: Colors.lightBlue.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(model.type),
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ],
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
