import 'package:flutter/material.dart';

import '../app_scaffold.dart';

class LendLibrary extends StatefulWidget {
  @override
  _LendLibraryState createState() => _LendLibraryState();
}

class _LendLibraryState extends State<LendLibrary> {

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
          Text('Lend Library'),
        ]
      )
    );
  }
}
