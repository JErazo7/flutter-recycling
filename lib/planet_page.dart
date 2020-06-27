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
  Offset _verticalDragStart;
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

  Animation<RelativeRect> _moonsRect(Size screen) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, screen.height * 0.45, 0.0, screen.height * 0.425),
      end: RelativeRect.fromLTRB(-50.0, screen.height * 0.7, -50.0, 0.0),
    ).animate(_swipeAnimController);
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _verticalDragStart = details.globalPosition;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_verticalDragStart.dy - details.globalPosition.dy > 50.0) {
      _swipeAnimController.reverse();
      _slideInAnimController.forward();
    }

    if (_verticalDragStart.dy - details.globalPosition.dy < 0.0) {
      _swipeAnimController.forward();
      _slideInAnimController.reverse();
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    _verticalDragStart = null;
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

    return GestureDetector(
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Material(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PositionedTransition(
              rect: _planetRect(screenSize),
              child: Hero(
                tag: widget.currentPlanet.name,
                child: CelestialBodyWidget(widget.currentPlanet.vidAssetPath),
              ),
            ),
            Positioned(
              right: -160 + (10.0 * (_swipeAnimController.value)),
              top: -100,
              child: IgnorePointer(
                ignoring: true,
                child: SlideTransition(
                  position:
                      Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
                          .animate(_onNavigationAnimController),
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.05)
                        .animate(_swipeAnimController),
                    child: Image.asset(
                      'assets/flare.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white, letterSpacing: 10.0),
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
      ),
    );
  }
}
