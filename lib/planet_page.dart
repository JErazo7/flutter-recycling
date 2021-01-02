import 'dart:convert';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recycling/Screen_camera.dart';
import 'package:flutter_recycling/model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:location/location.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'Screen_history.dart';
import 'Smoke_animated.dart';
import 'celestial_body_widget.dart';
import 'custom_page_routes.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key key}) : super(key: key);

  @override
  PlanetPageState createState() {
    return new PlanetPageState();
  }
}

class PlanetPageState extends State<PlanetPage> with TickerProviderStateMixin {
  Location location;
  final currentPlanet = Planet(
    name: 'Earth',
    color: Colors.blue,
    diameter: 1.0,
    description:
        'Earth is the third planet from the Sun and the only astronomical object known to harbor life.',
    intro:
        'Earth is the third planet from the Sun and the only astronomical object known to harbor life. According to radiometric dating and other sources of evidence, Earth formed over 4.5 billion years ago.',
    formation:
        'The oldest material found in the Solar System is dated to 4.5672±0.0006 billion years ago (Bya). By 4.54±0.04 Bya the primordial Earth had formed. The bodies in the Solar System formed and evolved with the Sun. In theory, a solar nebula partitions a volume out of a molecular cloud by gravitational collapse, which begins to spin and flatten into a circumstellar disk, and then the planets grow out of that disk with the Sun. A nebula contains gas, ice grains, and dust (including primordial nuclides). According to nebular theory, planetesimals formed by accretion, with the primordial Earth taking 10–20 million years (Mys) to form.',
    history:
        'Earth\'s atmosphere and oceans were formed by volcanic activity and outgassing. Water vapor from these sources condensed into the oceans, augmented by water and ice from asteroids, protoplanets, and comets.[60] In this model, atmospheric "greenhouse gases" kept the oceans from freezing when the newly forming Sun had only 70% of its current luminosity.[61] By 3.5 Bya, Earth\'s magnetic field was established, which helped prevent the atmosphere from being stripped away by the solar wind.',
    imgAssetPath: 'assets/earth.jpg',
    vidAssetPath: 'assets/earth.webp',
  );
  AnimationController _swipeAnimController;
  AnimationController _slideInAnimController;
  AnimationController _onNavigationAnimController;

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    location = new Location();
    updatePlace();
    _swipeAnimController =
        AnimationController(duration: Duration(milliseconds: 600))
          ..addListener(() {
            setState(() {});
          });

    _slideInAnimController = AnimationController(
      duration: Duration(milliseconds: 800),
    );

    _slideInAnimController.forward();
    _onNavigationAnimController = AnimationController(
      duration: Duration(milliseconds: 600),
    );
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

  var address = "";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.black,
      child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                  particleCount: 300,
                  spawnMaxSpeed: 5.0,
                  spawnMinSpeed: 1.0,
                  spawnMaxRadius: 1.5,
                  spawnMinRadius: 1.0,
                  baseColor: Colors.white)),
          vsync: this,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                  top: screenSize.width * 0.04,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.04),
                          child: Text(
                            '''What are you
recycling today?''',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          )),
                      SizedBox(height: screenSize.width * 0.02),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.04),
                          child: Text(
                            'Recycle to save our planet',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                          )),
                      SizedBox(height: screenSize.width * 0.04),
                      Card(
                        margin: EdgeInsets.only(left: 0),
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
                                Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenSize.width * 0.04),
                                      child: Text(address,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    )),
                                Expanded(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.gps_fixed,
                                          color: Colors.black,
                                          size: screenSize.width * 0.075,
                                        ),
                                        onPressed: () async => updatePlace))
                              ],
                            )),
                      ),
                      SizedBox(height: screenSize.width * 0.04),
                      Container(
                          width: screenSize.width,
                          child: FadeTransition(
                            opacity: _slideInAnimController,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                stats('''250
Plastic'''),
                                divider(screenSize),
                                stats('''350
Metal'''),
                                divider(screenSize),
                                stats('''150
Glass'''),
                                divider(screenSize),
                                stats('''450
Paper'''),
                              ],
                            ),
                          ))
                    ],
                  )),
              PositionedTransition(
                rect: _planetRect(screenSize),
                child: Hero(
                  tag: currentPlanet.name,
                  child: CelestialBodyWidget(currentPlanet.vidAssetPath),
                ),
              ),
              Positioned(
                  left: screenSize.width * 0.06,
                  bottom: screenSize.width * 0.65,
                  child: Container(
                      height: screenSize.width * 0.4,
                      width: screenSize.width * 0.4,
                      child: CircularPercentIndicator(
                        radius: screenSize.width * .2,
                        animation: true,
                        animationDuration: 20000,
                        circularStrokeCap: CircularStrokeCap.butt,
                        lineWidth: 5.0,
                        percent: 0.6,
                        center: Text("76%",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white)),
                        progressColor: Colors.blueGrey,
                      ))),
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
                          tag: '${currentPlanet.name}heading',
                          child: Text(
                            currentPlanet.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: Colors.white, letterSpacing: 10.0),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildSmoke(context),
              _buildSmoke1(context),
              _buildSmoke2(context),
              _buildBackBotton(context),
              Positioned(
                  right: screenSize.width * 0.1,
                  bottom: screenSize.width * 0.65,
                  child: IconButton(
                    iconSize: screenSize.width * 0.15,
                    icon: Icon(Icons.camera,
                        color: Colors.white, size: screenSize.width * 0.15),
                    onPressed: () {
                      _onNavigationAnimController.forward();
                      Navigator.of(context)
                          .push(
                        MyPageRoute(
                          transDuation: Duration(milliseconds: 600),
                          builder: (BuildContext context) {
                            return ScreenCamera();
                          },
                        ),
                      )
                          .then((_) {
                        _onNavigationAnimController.reverse();
                      });
                    },
                  )),
            ],
          )),
    );
  }

  Widget _buildSmoke(context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Astronaut(),
        ],
      ),
    );
  }

  Widget _buildSmoke1(context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Astronaut(),
        ],
      ),
    );
  }

  Widget _buildSmoke2(context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Astronaut(),
        ],
      ),
    );
  }

  Widget _buildBackBotton(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.075),
          child: Container(
            alignment: Alignment.topRight,
            height: MediaQuery.of(context).size.height * 0.125 / 1.65,
            width: MediaQuery.of(context).size.height * 0.125 / 1.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                      MediaQuery.of(context).size.height * 0.125 / 6),
                  topLeft: Radius.circular(
                      MediaQuery.of(context).size.height * 0.125 / 6)),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 15,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _onNavigationAnimController.forward();
                    Navigator.of(context)
                        .push(
                      MyPageRoute(
                        transDuation: Duration(milliseconds: 600),
                        builder: (BuildContext context) {
                          return History();
                        },
                      ),
                    )
                        .then((_) {
                      _onNavigationAnimController.reverse();
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }

  void updatePlace() async {
    setState(() {
      address = "Loading..";
    });
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData position;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      position = await location.getLocation();
      if (kIsWeb) {
        final resp = jsonDecode((await http.read(
            'https://geocode.xyz/${position.latitude},${position.longitude}?json=1')));
        setState(() {
          address = "${resp['city']}, ${resp['country']}";
        });
      } else {
        final coordinates =
            new Coordinates(position.latitude, position.longitude);

        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        setState(() {
          address = "${first.locality}, ${first.countryName}";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        address = "Error obtaining location";
      });
    }
  }

  Widget stats(String content) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
    );
  }

  Widget divider(Size screenSize) {
    return Container(
        height: screenSize.width * 0.15,
        child: VerticalDivider(
          color: Colors.white,
          thickness: 2,
          width: screenSize.width * 0.1,
        ));
  }
}
