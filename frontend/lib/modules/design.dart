import 'package:flutter/material.dart';

import '../app_scaffold.dart';

class Design extends StatefulWidget {
  @override
  _DesignState createState() => _DesignState();
}

class _DesignState extends State<Design> {

  //late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    //_videoController = VideoPlayerController.network(
    //  'https://www.youtube.com/watch?v=i0o6W7H-xEA',
    //);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      body: ListView(
        children: [
          Text('TODO'),
        ]
      )
    );
  }
}
