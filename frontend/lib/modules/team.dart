import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
     'bio':'''Vera was the Software Engineer on a buzzing team build tools to provide beekeepers all around the world with AI-Driven Climate-Smart Beekeeping. Prior to that, she created the RunPee app with her husband. Vera was born and raised in China. She was a Marketing Manager in Beijing and worked with Coca-cola China, and LinkedIn China, to name a few. Vera is a self-taught software engineer and believes in equal opportunities in all.'''
   },
 };


  @override
  Widget build(BuildContext context) {
    return AppScaffoldComponent(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: LayoutBuilder(
          builder: (context, constraints){
            int count = constraints.maxWidth > 600? 2:1;
            ScrollController _controller = ScrollController(keepScrollOffset: false);
            return GridView.count(
              controller: _controller,
              shrinkWrap: true,
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              crossAxisCount: count,
              children: _memberBuilder(),
            );
          },
        )
      )
    );
  }

  List<Widget> _memberBuilder(){
    List<Widget> _members = [];
    _membersImage.forEach((name, meta) {
      Widget memberBox = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                    child: Image(image: AssetImage(meta['imageUrl']))
                )
            ),
          ),
        Padding(
          padding: EdgeInsets.all(8),
          child: IntrinsicHeight(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            name,
                            style:Theme.of(context).textTheme.displaySmall),
                        IconButton(
                            onPressed: () async{
                              if (kIsWeb){
                                html.window.open( meta['linkedIn'], 'new tab');
                              } else {
                                if (await canLaunchUrl(meta['linkedIn'])){
                                  await launchUrl(meta['linkedIn']);
                                } else {
                                  throw "Could not launch ${meta}";
                                }

                              }
                            },
                            icon:FaIcon(
                              FontAwesomeIcons.linkedinIn,
                              size: 18,)
                        )
                      ],
                    ),
                    Expanded(child: Text(meta['bio'])),
                  ],
                ),
              ),
            ),
          ),
        ),
        ],
      );
      _members.add(memberBox);
    });

    return _members;
  }
}
