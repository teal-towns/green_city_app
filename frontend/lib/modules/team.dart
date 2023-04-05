import 'package:flutter/material.dart';

import '../app_scaffold.dart';

class Team extends StatefulWidget {
  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {

 Map<String, dynamic> _membersImage = {
   'Isak': {
     'imageUrl': 'images/people/isak.jpeg',
     'bio': 'placeholder placeholder placeholder placeholder placeholder',
   },
   'Lora': {
     'imageUrl': 'images/people/lora.jpeg',
     'bio': 'placeholder',
   },
   'Luke': {
     'imageUrl': 'images/people/luke.jpeg',
     'bio': 'placeholder',
   },
   'Vera': {
     'imageUrl': 'images/people/vera.jpeg',
     'bio':'placeholder',
   },
 };


  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _memberBuilder(),
        ),
      )
    );
  }

  List<Widget> _memberBuilder(){
    List<Widget> _members = [];
    _membersImage.forEach((name, meta) {
      Widget memberBox = Container(
        constraints: BoxConstraints(
          maxWidth: 200,
        ),
        child: Column(
          children: [
        SizedBox(
          width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image(image: AssetImage(meta['imageUrl']))
            )
        ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(12),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(name),
                      Text(meta['bio']),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );

      _members.add(memberBox);
    });


    return _members;
  }
}
