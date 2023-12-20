import 'package:flutter/material.dart';

import 'package:af_watches2/Constants/strings.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        const Spacer(flex: 6),
        const Spacer(flex: 6),
         RichText(
          textAlign: TextAlign.center,
          text:const TextSpan(
              text: 'A',
              style:TextStyle(color:   Color(0xfffa9a04), fontSize: 35,fontFamily: 'BabyShowerTime'),
              children: [
                TextSpan(
                  text: 'F',
                  style: TextStyle(color:   Color(0xfffa9a04), fontSize: 35),
                ),
                TextSpan(
                  text: ' ',
                  style: TextStyle(color:  Color(0xff9f6201), fontSize: 15),
                ),
                TextSpan(
                  text: 'Watches',
                  style: TextStyle(color:   Color(0xffD48203), fontSize: 30,fontFamily: 'DriverStationDemoBold',),
                ),
              ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.text!,
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          height: height*0.5,
          width: width*0.8,
        ),
      ],
    );
  }
}