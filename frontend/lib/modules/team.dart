import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;
import '../app_scaffold.dart';

class Team extends StatefulWidget {
  @override
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<Team> {

 Map<String, dynamic> _membersImage = {
   'Isak': {
     'imageUrl': 'assets/images/people/isak.jpeg',
     'linkedIn':'https://www.linkedin.com/in/isakdiaz/',
     'bio': '''Experienced Machine Learning Engineer with a demonstrated history of working in the renewables and environment industry. Skilled in Unity AR, Neural Networks, OpenCV, and Google Cloud. Strong engineering professional with a Master’s degree focused in Computer Science from Georgia Institute of Technology.''',
   },
   'Lora': {
     'imageUrl': 'assets/images/people/lora.jpeg',
     'linkedIn': 'https://www.linkedin.com/in/lora-madera-683872142/',
     'bio': '''Lora is a frontend developer and UI / UX designer with experience developing and implementing visual designs in both 3D-modeling software and code ( Flutter , React , Unity, Blender for 3D-modeling ) and utilizing the full Adobe client & prototyping tools (Illustrator, Photoshop, InDesign, After Effects, Premiere Pro, XD, Figma)''',
   },
   'Luke': {
     'imageUrl': 'assets/images/people/luke.jpeg',
     'linkedIn': 'https://www.linkedin.com/in/lukemadera/',
     'bio': '''Luke is born and raised in the Bay Area and grew up camping with his family, which is part of where his love for nature came from. In college he dreamed of mixing his passions of health and fitness, the environment and community together to start a Green Gym. After 15 years of software development and entrepreneurship spanning full stack, mobile, Unity and machine learning, that pulled him away from environmental work, he found his way back to it'''

   },
   'Vera': {
     'imageUrl': 'assets/images/people/vera.jpeg',
     'linkedIn': 'https://www.linkedin.com/in/xuewei-qian-vera-68927695/',
     'bio':'''Vera was the Software Engineer on a buzzing team that helps the bees, by building tools to provide beekeepers all around the world with AI-Driven Climate-Smart Beekeeping. Prior to that, she created the RunPee app with her husband. \nVera was born and raised in China. Another lifetime ago, she was a Marketing Manager in Beijing and worked with Coca-cola China, and LinkedIn China, to name a few. Vera is a self-taught software engineer and believes in equal opportunities in all aspects. She loves to live the local life wherever she travels, and never feels like an outsider on this planet named earth. She is living in the Blue Ridge mountains and loves the outdoors'''
   },
 };


  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
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
          maxWidth: 200
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name),
                          IconButton(
                              onPressed: (){
                                html.window.open(meta['linkedIn'], 'new tab');
                              },
                              icon:FaIcon(
                                FontAwesomeIcons.linkedinIn,
                                size: 18,)
                          )
                        ],
                      ),
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
