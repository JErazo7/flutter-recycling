import 'dart:async';
import 'package:flutter/material.dart';
import 'model.dart';

class Astronaut extends StatefulWidget {
  final Size size;
  final List<Planet> planets;
  final int currentPlanetIndex;
  final Stream shouldNavigate;

  const Astronaut(
      {Key key,
        this.size,
        this.planets,
        this.currentPlanetIndex,
        this.shouldNavigate})
      : super(key: key);
  @override
  AstronautState createState() {
    return new AstronautState();
  }
}

class AstronautState extends State<Astronaut> with TickerProviderStateMixin {
  AnimationController _smokeAnimController;
  AnimationController _scaleAnimController;
  AnimationController _floatingAnimController;
  Animation<Offset> _floatingAnim;

  @override
  void initState() {
    super.initState();
    _smokeAnimController =
        AnimationController(duration: Duration(seconds: 35), vsync: this);

    _floatingAnimController = AnimationController(
        duration: Duration(milliseconds: 1700), vsync: this);

    _floatingAnim = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.025))
        .animate(_floatingAnimController);

    _smokeAnimController.repeat();

    _floatingAnimController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _floatingAnimController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _floatingAnimController.forward();
      }
    });

    _floatingAnimController.forward();

    _scaleAnimController = AnimationController(
        lowerBound: 1.0,
        upperBound: 7.0,
        duration: Duration(milliseconds: 700),
        vsync: this);
  }



  @override
  void dispose() {
    super.dispose();
    _smokeAnimController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height*0.3;
    return SlideTransition(
      position: _floatingAnim,
      child: ScaleTransition(
        scale: _scaleAnimController,
        child: Container(
          color: Colors.transparent,
          width: size,
          height: size,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topRight,
            children: <Widget>[
              Positioned(
                top: 0.0 ,
                child: RotationTransition(
                  turns: _smokeAnimController,
                  child: Image.asset(
                    'assets/spacesmoke.png',
                    fit: BoxFit.cover,
                    color: Colors.white.withOpacity(0.3),
                    width: size,
                    height: size,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
