import 'package:flutter/material.dart';
import 'package:flutter_recycling/model.dart';
import 'celestial_body_widget_h.dart';

class PlanetPageh extends StatefulWidget {
  final Planet currentPlanet;
  const PlanetPageh({Key key, this.currentPlanet}) : super(key: key);

  @override
  _PlanetPagehState createState() {
    return _PlanetPagehState();
  }
}

class _PlanetPagehState extends State<PlanetPageh> with TickerProviderStateMixin {
  AnimationController _swipeAnimController;
  AnimationController _slideInAnimController;
  AnimationController _onNavigationAnimController;


  @override
  void initState() {
    super.initState();
    _swipeAnimController =
    AnimationController(duration: Duration(milliseconds: 600), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _slideInAnimController =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _slideInAnimController.forward();
    _onNavigationAnimController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
  }

  @override
  void dispose() {
    _swipeAnimController.dispose();
    _slideInAnimController.dispose();
    _onNavigationAnimController.dispose();
    super.dispose();
  }

  Animation<RelativeRect> _planetRect(Size screen) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(-50.0, 0.0, -50.0, screen.height*0.7),
      end: RelativeRect.fromLTRB(-50.0,screen.height * 0.3 , -50.0, screen.height * 0.7),
    ).animate(_swipeAnimController);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return PositionedTransition(
          rect: _planetRect(screenSize),
          child: Hero(
            tag: widget.currentPlanet.name,
            child: CelestialBodyWidgeth(widget.currentPlanet.vidAssetPath),
          ),
    );
  }
}
