import 'dart:math';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Smoke_animated.dart';
import 'model.dart';
import 'planet_pageh.dart';

class History extends StatefulWidget {
  @override
  HistoryState createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> with TickerProviderStateMixin {
  DrinkData _selectedDrink;
  ScrollController _scrollController = ScrollController();
  List<DrinkData> _drinks;
  int _earnedPoints;
  AnimationController _onNavigationAnimController;


  @override
  void initState() {
    _onNavigationAnimController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    var demoData = DemoData();
    _drinks = demoData.drinks;
    _earnedPoints = demoData.earnedPoints;
    super.initState();
  }

  @override
  void dispose() {
    _onNavigationAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
            children: <Widget>[
              ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.18,
                    top: MediaQuery.of(context).size.height * 0.3),
                itemCount: _drinks.length,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemBuilder: (context, index) => _buildListItem(index),
              ),
              _buildBottomContent(context),
              _planet(context),
              _buildSmoke(context),
              _buildSmoke1(context),
              _buildSmoke2(context),
              _buildBackBotton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackBotton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(),
        Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.height * 0.075),
          child: Container(
            alignment: Alignment.topRight,
            height: MediaQuery.of(context).size.height * 0.125 / 1.65,
            width: MediaQuery.of(context).size.height * 0.125 / 1.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      MediaQuery.of(context).size.height * 0.125 / 6),
                  bottomRight: Radius.circular(
                      MediaQuery.of(context).size.height * 0.125 / 6)),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmoke(context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.055),
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

  Widget _planet(context) {
    return PlanetPageh(
      currentPlanet: Planet(
        name: 'Earth',
        color: Colors.blue,
        diameter: 1.0,
        imgAssetPath: 'assets/earth.jpg',
        vidAssetPath: 'assets/earth.webp',
      ),
    );
  }

  Widget _buildBottomContent(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MediaQuery.of(context).size.width / 9),
              topRight: Radius.circular(MediaQuery.of(context).size.width / 9)),
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0125),
        height: MediaQuery.of(context).size.height * 0.175,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Balance Points",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "My Points",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star,
                    color: Colors.yellow[900],
                    size: MediaQuery.of(context).size.height * 0.045),
                SizedBox(width: 8),
                Text(
                  "$_earnedPoints",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.025 / 2,
          horizontal: MediaQuery.of(context).size.height * 0.025),
      child: DrinkListCard(
        earnedPoints: _earnedPoints,
        drinkData: _drinks[index],
        isOpen: _drinks[index] == _selectedDrink,
        onTap: _handleDrinkTapped,
      ),
    );
  }

  void _handleDrinkTapped(DrinkData data) {
    setState(() {
      //If the same drink was tapped twice, un-select it
      if (_selectedDrink == data) {
        _selectedDrink = null;
      }
      //Open tapped drink card and scroll to it
      else {
        _selectedDrink = data;
        var selectedIndex = _drinks.indexOf(_selectedDrink);
        var closedHeight = DrinkListCard.nominalHeightClosed;
        //Calculate scrollTo offset, subtract a bit so we don't end up perfectly at the top
        var offset = selectedIndex *
            (closedHeight + MediaQuery.of(context).size.height * 0.025) -
            closedHeight * .35;
        _scrollController.animateTo(offset,
            duration: Duration(milliseconds: 700), curve: Curves.easeOutQuad);
      }
    });
  }
}

class Styles {
  static TextStyle text(double size, Color color, bool bold, {double height}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      height: height,
    );
  }
}

class RoundedShadow extends StatelessWidget {
  final Widget child;
  final Color shadowColor;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  const RoundedShadow(
      {Key key,
        this.shadowColor,
        this.topLeftRadius = 48,
        this.topRightRadius = 48,
        this.bottomLeftRadius = 48,
        this.bottomRightRadius = 48,
        this.child})
      : super(key: key);

  const RoundedShadow.fromRadius(double radius,
      {Key key, this.child, this.shadowColor})
      : topLeftRadius = radius,
        topRightRadius = radius,
        bottomLeftRadius = radius,
        bottomRightRadius = radius;

  @override
  Widget build(BuildContext context) {
    //Create a border radius, the only applies to the bottom
    var r = BorderRadius.only(
      topLeft: Radius.circular(topLeftRadius),
      topRight: Radius.circular(topRightRadius),
      bottomLeft: Radius.circular(bottomLeftRadius),
      bottomRight: Radius.circular(bottomRightRadius),
    );
    var sColor = shadowColor ?? Color(0x20000000);

    var maxRadius = [
      topLeftRadius,
      topRightRadius,
      bottomLeftRadius,
      bottomRightRadius
    ].reduce(max);
    return Container(
      decoration: new BoxDecoration(
        borderRadius: r,
        boxShadow: [new BoxShadow(color: sColor, blurRadius: maxRadius * .5)],
      ),
      child: ClipRRect(borderRadius: r, child: child),
    );
  }
}

class LiquidSimulation {
  int curveCount = 4;
  List<Offset> ctrlPts = [];
  List<Offset> endPts = [];
  List<Animation<double>> ctrlTweens = [];

  double endPtX1 = .5;
  double endPtY1 = 1;
  double duration;
  double time;
  double xOffset = 0;

  final ElasticOutCurve _ease = ElasticOutCurve(.15);

  double hzScale;
  double hzOffset;

  void start(AnimationController controller, bool flipY) {
    //Each time the controller ticks, update our control points, using the latest tween values
    controller.addListener(updateControlPointsFromTweens);
    //Calculate gap between each ctrl/end pt.
    var gap = 1 / (curveCount * 2.0);

    //Randomly scale and offset each simulation, for more variety
    hzScale = 1.25 + Random().nextDouble() * .5;
    hzOffset = -.2 + Random().nextDouble() * .4;

    //Create end points, these sit at yPos=0, and don't animate
    endPts.clear();
    //For n curves, we need n + 2 endpoints
    //Create first end point
    endPts.insert(0, Offset(0, 0)); //Start at 0,0
    for (var i = 1; i < curveCount; i++) {
      endPts.add(Offset(gap * i * 2, 0));
    }
    //Last endpoint at 1,0
    endPts.add(Offset(1, 0));

    //Create control points, these animate on the Y axis
    ctrlPts.clear();
    for (var i = 0; i < curveCount + 1; i++) {
      //Choose random height for this control pt
      var height = (.5 + Random().nextDouble() * .5) *
          (i % 2 == 0 ? 1 : -1) *
          (flipY ? -1 : 1);
      //Create a 3 part tween, does nothing for a bit, then easesOut to 'height', then elastic snaps back to 0
      var animSequence = TweenSequence([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: height)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: height, end: 0)
              .chain(CurveTween(curve: _ease)),
          weight: 60.0,
        )
      ]).animate(controller);
      ctrlTweens.add(animSequence);
      ctrlPts.add(Offset(gap + gap * i * 2, height));
    }
  }

  List<Offset> updateControlPointsFromTweens() {
    for (var i = 0; i < ctrlPts.length; i++) {
      var o = ctrlPts[i];
      ctrlPts[i] = Offset(o.dx, ctrlTweens[i].value);
    }
    return ctrlPts;
  }
}

class LiquidPainter extends CustomPainter {
  final double fillLevel;
  final LiquidSimulation simulation1;
  final LiquidSimulation simulation2;
  final double waveHeight;

  LiquidPainter(this.fillLevel, this.simulation1, this.simulation2,
      {this.waveHeight = 200});

  @override
  void paint(Canvas canvas, Size size) {
    _drawLiquidSim(
        simulation1, canvas, size, 0, Colors.blueGrey[300].withOpacity(.4));
    _drawLiquidSim(
        simulation2, canvas, size, 5, Colors.blueGrey[300].withOpacity(.4));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawLiquidSim(LiquidSimulation simulation, Canvas canvas, Size size,
      double offsetY, Color color) {
    canvas.scale(simulation.hzScale, 1);
    canvas.translate(simulation.hzOffset * size.width, offsetY);

    //_drawOffsets(simulation, canvas, size);

    //Create a path around bottom and sides of card
    var path = Path()
      ..moveTo(size.width * 1.25, 0)
      ..lineTo(size.width * 1.25, size.height)
      ..lineTo(-size.width * .25, size.height)
      ..lineTo(-size.width * .25, 0);

    //Loop through simulation control and end points, drawing each as a pair
    for (var i = 0; i < simulation.curveCount; i++) {
      var ctrlPt = sizeOffset(simulation.ctrlPts[i], size);
      var endPt = sizeOffset(simulation.endPts[i + 1], size);
      path.quadraticBezierTo(ctrlPt.dx, ctrlPt.dy, endPt.dx, endPt.dy);
    }
    canvas.drawPath(path, Paint()..color = color);

    canvas.translate(-simulation.hzOffset * size.width, -offsetY);
    canvas.scale(1 / simulation.hzScale, 1);
  }

  Offset sizeOffset(Offset pt, Size size) {
    return Offset(pt.dx * size.width, waveHeight * pt.dy);
  }
}

class DrinkListCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 296;

  final Function(DrinkData) onTap;

  final bool isOpen;
  final DrinkData drinkData;
  final int earnedPoints;

  const DrinkListCard(
      {Key key,
        this.drinkData,
        this.onTap,
        this.isOpen = false,
        this.earnedPoints = 100})
      : super(key: key);

  @override
  _DrinkListCardState createState() => _DrinkListCardState();
}

class _DrinkListCardState extends State<DrinkListCard>
    with TickerProviderStateMixin {
  bool _wasOpen;
  Animation<double> _fillTween;
  Animation<double> _pointsTween;
  AnimationController _liquidSimController;

  //Create 2 simulations, that will be passed to the LiquidPainter to be drawn.
  LiquidSimulation _liquidSim1 = LiquidSimulation();
  LiquidSimulation _liquidSim2 = LiquidSimulation();

  @override
  void initState() {
    //Create a controller to drive the "fill" animations
    _liquidSimController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _liquidSimController.addListener(_rebuildIfOpen);
    //create tween to raise the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _liquidSimController,
          curve: Interval(.12, .45, curve: Curves.easeOut)),
    );
    //create tween to animate the 'points remaining' text
    _pointsTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _liquidSimController,
          curve: Interval(.1, .5, curve: Curves.easeOutQuart)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //If our open state has changed...
    if (widget.isOpen != _wasOpen) {
      //Kickoff the fill animations if we're opening up
      if (widget.isOpen) {
        //Start both of the liquid simulations, they will initialize to random values
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);
        //Run the animation controller, kicking off all tweens
        _liquidSimController.forward(from: 0);
      }
      _wasOpen = widget.isOpen;
    }

    //Determine the points required text value, using the _pointsTween

    var pointsValue = _pointsTween.value * (widget.earnedPoints);
    //Determine current fill level, based on _fillTween
    double _maxFillLevel =
    min(1, widget.earnedPoints / widget.drinkData.requiredPoints);
    double fillLevel = _maxFillLevel; //_maxFillLevel * _fillTween.value;
    double cardHeight = widget.isOpen
        ? DrinkListCard.nominalHeightOpen
        : DrinkListCard.nominalHeightClosed;

    return GestureDetector(
      onTap: _handleTap,
      //Use an animated container so we can easily animate our widget height
      child: AnimatedContainer(
        curve: !_wasOpen ? ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: cardHeight,
        //Wrap content in a rounded shadow widget, so it will be rounded on the corners but also have a drop shadow
        child: RoundedShadow.fromRadius(
          12,
          child: Container(
            color: Colors.white.withOpacity(0.15),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //Background liquid layer
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1 : 0,
                  duration: Duration(milliseconds: 500),
                  child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                ),

                //Card Content
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.0125,
                      right: MediaQuery.of(context).size.height * 0.025),
                  //Wrap content in a ScrollView, so there's no errors on over scroll.
                  child: SingleChildScrollView(
                    //We don't actually want the scrollview to scroll, disable it.
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        //Top Header Row
                        _buildTopContent(),
                        //Spacer
                        SizedBox(height: 12),
                        //Bottom Content, use AnimatedOpacity to fade
                        AnimatedOpacity(
                          duration: Duration(
                              milliseconds: widget.isOpen ? 1000 : 500),
                          curve: Curves.easeOut,
                          opacity: widget.isOpen ? 1 : 0,
                          //Bottom Content
                          child: _buildBottomContent(pointsValue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
              0,
              DrinkListCard.nominalHeightOpen * 1.2 -
                  DrinkListCard.nominalHeightOpen *
                      _fillTween.value *
                      _maxFillLevel *
                      1.2),
          child: CustomPaint(
            painter: LiquidPainter(fillLevel, _liquidSim1, _liquidSim2,
                waveHeight: 100),
          ),
        ),
      ],
    );
  }

  Row _buildTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //Icon
        SizedBox(width: MediaQuery.of(context).size.height * 0.0125),
        //Label
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DATE RECYCLING LIST',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                widget.drinkData.date,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //Star Icon
            Icon(
              Icons.star,
              size: 20,
              color: Colors.yellow[900],
            ),
            SizedBox(width: 4),
            //Points Text
            Text(
              "${widget.drinkData.wonPoints}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildBottomContent(double pointsValue) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Column(children: <Widget>[
                Text(
                  'Material:',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Glass',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Metal',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Paper',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Plastic',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
            ),
            Center(
              child: Column(children: <Widget>[
                Text(
                  'Items:',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${widget.drinkData.glass}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.metal}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.paper}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.plastic}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
            Center(
              child: Column(children: <Widget>[
                Text(
                  'Points: ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${widget.drinkData.glass*20}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.metal*30}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.paper*10}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${widget.drinkData.plastic*40}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ]),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0125 * 2),
        Text(
          "Congratulations!",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "You've received ",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              " ${widget.drinkData.wonPoints.round()} ",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              " points!",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
        //Main Button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.height * 0.225,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FlatButton(
                //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
                onPressed: null,
                color: Colors.blue,
                disabledColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Text("OK",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap(widget.drinkData);
    }
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }
}

class DrinkData {
  final String date;
  final int requiredPoints;
  final int wonPoints;
  final int glass;
  final int metal;
  final int paper;
  final int plastic;

  DrinkData(
    this.date,
    this.requiredPoints,
    this.wonPoints,
    this.glass,
    this.metal,
    this.paper,
    this.plastic,
  );
}

class DemoData {
  //how many points this user has earned, in a real app this would be loaded from an online service.
  int earnedPoints = 1100;

  //List of available drinks
  List<DrinkData> drinks = [
    DrinkData('25/06/2020', 2, 150, 0, 1, 0, 3),
    DrinkData('26/06/2020', 2, 440, 12, 0, 10, 3),
    DrinkData('27/06/2020', 2, 280,0, 9, 1, 0),
    DrinkData('28/06/2020', 2, 230,0, 1, 0, 5),
  ];
}

class MaterialsData {
  final String title;
  final int addPoints;

  MaterialsData(
    this.title,
    this.addPoints,
  );
}

class Materials {
  List<MaterialsData> materials = [
    MaterialsData("Plastic", 40),
    MaterialsData('Paper', 10),
    MaterialsData('Glass', 20),
    MaterialsData('Metal', 30),
  ];
}
