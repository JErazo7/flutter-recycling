import 'package:flutter/material.dart';
import 'package:flutter_recycling/model.dart';
import 'celestial_body_widget_h.dart';

class PlanetPageh extends StatefulWidget {
  final Planet currentPlanet;

  const PlanetPageh({Key key, this.currentPlanet}) : super(key: key);

  @override
  PlanetPagehState createState() {
    return new PlanetPagehState();
  }
}

class PlanetPagehState extends State<PlanetPageh> with TickerProviderStateMixin {
  AnimationController _swipeAnimController;
  AnimationController _slideInAnimController;
  AnimationController _onNavigationAnimController;

  TabController _tabController;

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
    _tabController.dispose();
    _slideInAnimController.dispose();
    _onNavigationAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.3,
      child: Align(
        alignment: Alignment.topCenter,
        child:Hero(
          tag: widget.currentPlanet.name,
          child: CelestialBodyWidgeth(widget.currentPlanet.vidAssetPath),
        ),
      ),
    );
  }
}
