import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as youtubeMobile;


class CustomYoutubePlayer extends StatefulWidget {
  final String videoId;
  CustomYoutubePlayer({required this.videoId});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late YoutubePlayerController _webController;
  late youtubeMobile.YoutubePlayerController _mobileController;

  void initState() {
    super.initState();
    if(kIsWeb){
      _webController = YoutubePlayerController.fromVideoId(
        videoId: widget.videoId,
        autoPlay: false,
        params: const YoutubePlayerParams(showFullscreenButton: true),
      );
    } else{
      _mobileController = youtubeMobile.YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: youtubeMobile.YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb? YoutubePlayerScaffold(
      controller: _webController,
      aspectRatio: 16/9,
      builder: (context, player){
        return player;
      },
    ): youtubeMobile.YoutubePlayerBuilder(
      player: youtubeMobile.YoutubePlayer(
        controller: _mobileController,
      ),
      builder: (context, player){
        return player;
      },
    );
  }


  @override
  void dispose(){
    kIsWeb? _webController.close():_mobileController.dispose();
    super.dispose();
  }
}
