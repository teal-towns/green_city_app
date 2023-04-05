import 'package:flutter/material.dart';
import 'package:green_city_app/common/youtube_service.dart';

import '../app_scaffold.dart';

class Design extends StatefulWidget {
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {

  static const Map<String, String> _videosLabelAndId = {
    'Bioplan':'i0o6W7H-xEA',
    'Flythrough':'balxUsoU1gU',
  };

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      body: ListView.builder(
          itemCount: _videosLabelAndId.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CustomYoutubePlayer(videoId: _videosLabelAndId.values.elementAt(index)),
                  Text(_videosLabelAndId.keys.elementAt(index))
                ],
              ),
            );
          })
    );
  }

}
