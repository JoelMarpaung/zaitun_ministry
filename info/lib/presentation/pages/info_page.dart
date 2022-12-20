// ignore_for_file: library_private_types_in_public_api

import 'package:core/widgets/top_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info/domain/entities/info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/info_data_bloc/info_data_bloc.dart';
import '../bloc/info_data_bloc/info_data_event.dart';
import '../bloc/info_data_bloc/info_data_state.dart';

import '../widgets/social_media_tile.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int year = DateTime.now().year;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfoDataBloc, InfoState>(
      builder: (context, state) {
        if (state is InfoEmpty) {
          BlocProvider.of<InfoDataBloc>(context).add(const OnFetchDataInfo());
          return Stack(
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
              TopTitle(
                height: 80,
                blurRadius: 30,
                text: 'Info Radio',
              )
            ],
          );
        } else if (state is InfoLoading) {
          return Stack(
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
              TopTitle(
                height: 80,
                blurRadius: 30,
                text: 'Info Radio',
              )
            ],
          );
        } else if (state is InfoError) {
          return Stack(
            children: [
              Center(
                child: Text(state.message),
              ),
              const TopTitle(
                height: 80,
                blurRadius: 30,
                text: 'Info Radio',
              )
            ],
          );
        } else if (state is InfoHasData) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 110),
                child: buildIListInfo(state.result),
              ),
              const TopTitle(
                height: 80,
                blurRadius: 30,
                text: 'Info Radio',
              )
            ],
          );
        } else {
          return Container();
        }
      },
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
                color: Colors.blue.shade800,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(data.address,
                          style: GoogleFonts.roboto(
                              fontSize: 17, color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(data.description,
                          style: GoogleFonts.roboto(
                              fontSize: 17, color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final googleMap = data.googleMap;
                          final Uri url = Uri.parse(googleMap);
                          if (!await launchUrl(url,
                              mode: LaunchMode.externalApplication)) {
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
              ),
              Divider(
                thickness: 1,
                color: Colors.brown.shade400,
              ),
              _license(),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _license() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
              "Zaitun radio mobile application is designed and developed by Zaitun application developers.\n"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Copyright \u00a9"),
              Text(" $year"),
              const Text(" Radio Zaitun."),
              const Text(" All rights reserved.")
            ],
          ),
          const Text('\nApp. version 2.0.0'),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
