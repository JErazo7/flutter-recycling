import 'package:flutter/material.dart';


class Astronaut extends StatefulWidget {

  @override
  AstronautState createState() {
    return new AstronautState();
  }
}

class AstronautState extends State<Astronaut> with TickerProviderStateMixin {
  AnimationController _smokeAnimController;


  @override
  void initState() {
    super.initState();
    _smokeAnimController =
        AnimationController(duration: Duration(seconds: 35), vsync: this);
    _smokeAnimController.repeat();
  }


  @override
  void dispose() {
    _smokeAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery
        .of(context)
        .size
        .width * 0.55;
    return Container(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotationTransition(
            turns: _smokeAnimController,
            child: Image.asset(
              'assets/spacesmoke.png',
              fit: BoxFit.cover,
              color: Colors.white.withOpacity(0.5),
              width: size,
              height: size,
            ),
          ),
        ],
      ),
    );
  }
}



