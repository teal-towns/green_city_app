import 'package:flutter/material.dart';
import '../common/youtube_service.dart';

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
      body: Wrap(
          alignment: WrapAlignment.center,
          children: _videoBuilder(),
          )
    );
  }

  List<Widget> _videoBuilder(){
      List<Widget> _videos = [];
      _videosLabelAndId.forEach((name, id) {
        Widget _video = Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                  constraints: BoxConstraints(
                    maxWidth: 500
                  ),
                  child: CustomYoutubePlayer(videoId: id)),
              Text(name)
            ],
          ),
        );
        _videos.add(_video);
      });
    return _videos;
  }
}
