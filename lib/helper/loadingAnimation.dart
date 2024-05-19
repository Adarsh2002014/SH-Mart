import 'dart:async';

import 'package:flutter/material.dart';
class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  var dots = "";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 600), (timer)=>changeDots());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   height: 80,
        //   width: 80,
        //   decoration: BoxDecoration(
        //     color: Colors.transparent,
        //       image: DecorationImage(
        //         image: AssetImage(getUrl()),
        //         fit: BoxFit.cover,
        //       ),
        //       borderRadius: BorderRadius.circular(50)
        //   ),
        // ),
        Text("Loading$dots", style: const TextStyle(fontSize: 20, fontFamily: "Dashiki")),
      ],
    );
  }

  getUrl(){
    String url = "assets/black_loader.gif";
    if(Theme.of(context).brightness == Brightness.light) {
      url = "assets/white_loader.gif";
    }
    return url;
  }

  changeDots(){
    if(dots.length == 3){
      dots = "";
    }else{
      dots += ".";
    }
    setState(() {});
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
