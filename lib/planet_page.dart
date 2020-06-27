import 'package:flutter/material.dart';
import 'package:flutter_recycling/model.dart';

import 'celestial_body_widget.dart';
import 'custom_page_routes.dart';
import 'planets_details_page.dart';

class PlanetPage extends StatefulWidget {
  final Planet currentPlanet;

  const PlanetPage({Key key, this.currentPlanet}) : super(key: key);

  @override
  PlanetPageState createState() {
    return new PlanetPageState();
  }
}

class PlanetPageState extends State<PlanetPage> with TickerProviderStateMixin {
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

  Animation<RelativeRect> _planetRect(Size screen) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(-50.0, screen.height * 0.7, -50.0, 0.0),
      end: RelativeRect.fromLTRB(-50.0, screen.height, -50.0, -screen.height),
    ).animate(_swipeAnimController);
  }

  Column _descriptionColumn(CelestialBody celestialBody) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          celestialBody.description,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12.0,
            height: 1.5,
          ),
        ),
        FlatButton(
          child: Text(
            'Read More',
            style: TextStyle(
              color: Colors.white54,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            _onNavigationAnimController.forward();
            Navigator.of(context)
                .push(
              MyPageRoute(
                transDuation: Duration(milliseconds: 600),
                builder: (BuildContext context) {
                  return PlanetDetailsPage(
                    selected: celestialBody,
                  );
                },
              ),
            )
                .then((_) {
              _onNavigationAnimController.reverse();
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Material(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              top: screenSize.width * 0.04,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.04),
                      child: Text(
                        '''What are you 
recycling today?''',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(height: screenSize.width * 0.02),
                  Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.04),
                      child: Text(
                        'Recycle to save our planet',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      )),
                  SizedBox(height: screenSize.width * 0.04),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)),
                    ),
                    child: Container(
                        width: screenSize.width * 0.86,
                        height: screenSize.width * 0.14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenSize.width * 0.04),
                              child: Text('Manta, Ecuador',
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.gps_fixed,
                                  color: Colors.black,
                                  size: screenSize.width * 0.075,
                                ),
                                onPressed: null)
                          ],
                        )),
                  )
                ],
              )),
          PositionedTransition(
            rect: _planetRect(screenSize),
            child: Hero(
              tag: widget.currentPlanet.name,
              child: CelestialBodyWidget(widget.currentPlanet.vidAssetPath),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: screenSize.width * 0.15,
            left: screenSize.width * 0.15,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 1.0),
                end: Offset(0.0, 0.0),
              ).animate(_slideInAnimController),
              child: FadeTransition(
                opacity: _slideInAnimController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: '${widget.currentPlanet.name}heading',
                      child: Text(
                        widget.currentPlanet.name.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white, letterSpacing: 10.0),
                      ),
                    ),
                    _descriptionColumn(widget.currentPlanet),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
