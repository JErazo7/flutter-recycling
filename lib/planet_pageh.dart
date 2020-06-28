import 'package:flutter/material.dart';
import 'package:flutter_recycling/model.dart';
import 'celestial_body_widget.dart';

class PlanetPageh extends StatefulWidget {
  final Planet currentPlanet;
  const PlanetPageh({Key key, this.currentPlanet}) : super(key: key);

  @override
  PlanetPagehState createState() {
    return  PlanetPagehState();
  }
}

class PlanetPagehState extends State<PlanetPageh> with TickerProviderStateMixin {
  AnimationController _swipeAnimController;
  @override
  void initState() {
    super.initState();
    _swipeAnimController =
    AnimationController(duration: Duration(milliseconds: 600), vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _swipeAnimController.dispose();
    super.dispose();
  }

  Animation<RelativeRect> _planetRect(Size screen) {
    return RelativeRectTween(
      begin:RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_swipeAnimController);
  }



  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size/7;
    return SafeArea(
      child:Container(
        child: PositionedTransition(
          rect: _planetRect(screenSize),
          child: Hero(
            tag: widget.currentPlanet.name,
            child: CelestialBodyWidgeth(widget.currentPlanet.vidAssetPath),
          ),
        ),
      ),
    );
  }

}
