import 'dart:math';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    var demoData = DemoData();
    _drinks = demoData.drinks;
    _earnedPoints = demoData.earnedPoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.2,
                    top: MediaQuery.of(context).size.height * 0.275),
                itemCount: _drinks.length,
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                itemBuilder: (context, index) => _buildListItem(index),
              ),
              _buildBottomContent(context),
              _planet(context),
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
          padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.075),
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
                    //TODO: Route navigator back
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _planet(context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.transparent,
        child: PlanetPageh(
          currentPlanet: Planet(
            name: 'Earth',
            color: Colors.blue,
            diameter: 1.0,
            imgAssetPath: 'assets/earth.jpg',
            vidAssetPath: 'assets/earth.webp',
          ),
        ),
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
        height: MediaQuery.of(context).size.height * 0.2,
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
                fontSize: MediaQuery.of(context).size.height * 0.06,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star,
                    color: Colors.green,
                    size: MediaQuery.of(context).size.height * 0.045),
                SizedBox(width: 8),
                Text(
                  "$_earnedPoints",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
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

class AppColors {
  static Color orangeAccent = Color(0xfff1a35d);
  static Color orangeAccentLight = Color(0xffff7f33);
  static Color redAccent = Color(0xfff1a35d);
  static Color grey = Colors.grey[300];
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

  final ElasticOutCurve _ease = ElasticOutCurve(.3);

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
        simulation1, canvas, size, 0, Color(0xffC48D3B).withOpacity(.4));
    _drawLiquidSim(
        simulation2, canvas, size, 5, Color(0xff9D7B32).withOpacity(.4));
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

  void _drawOffsets(LiquidSimulation simulation, Canvas canvas, Size size) {
    var floor = size.height;
    simulation1.endPts.forEach((pt) {
      canvas.drawCircle(sizeOffset(pt, size), 4, Paint()..color = Colors.red);
    });
    simulation1.ctrlPts.forEach((pt) {
      canvas.drawCircle(sizeOffset(pt, size), 4, Paint()..color = Colors.green);
    });
  }

  Offset sizeOffset(Offset pt, Size size) {
    return Offset(pt.dx * size.width, waveHeight * pt.dy);
  }
}

class DrinkListCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 290;

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
    var pointsRequired = widget.drinkData.requiredPoints;
    var pointsValue = pointsRequired -
        _pointsTween.value * min(widget.earnedPoints, pointsRequired);
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
          child: Opacity(
            opacity: 1.0,
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
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
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
      children: <Widget>[
        //Icon
        SizedBox(width: 24),
        //Label
        Expanded(
          child: Text(
            widget.drinkData.title.toUpperCase(),
            style: Styles.text(18, Colors.white, true),
          ),
        ),
        //Star Icon
        Icon(Icons.star, size: 20, color: AppColors.orangeAccent),
        SizedBox(width: 4),
        //Points Text
        Text("${widget.drinkData.requiredPoints}",
            style: Styles.text(20, Colors.white, true))
      ],
    );
  }

  Column _buildBottomContent(double pointsValue) {
    bool isDisabled = widget.earnedPoints < widget.drinkData.requiredPoints;

    List<Widget> rowChildren = [];
    if (pointsValue == 0) {
      rowChildren.add(
          Text("Congratulations!", style: Styles.text(16, Colors.white, true)));
    } else {
      rowChildren.addAll([
        Text("You're only ", style: Styles.text(12, Colors.white, false)),
        Text(" ${pointsValue.round()} ",
            style: Styles.text(16, AppColors.orangeAccent, true)),
        Text(" points away", style: Styles.text(12, Colors.white, false)),
      ]);
    }

    return Column(
      children: [
        //Body Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        SizedBox(height: 16),
        Text(
          "Redeem your points for a cup of happiness! Our signature espresso is blanced with steamed milk and topped with a light layer of foam. ",
          textAlign: TextAlign.center,
          style: Styles.text(14, Colors.white, false, height: 1.5),
        ),
        SizedBox(height: 16),
        //Main Button
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: Opacity(
            opacity: isDisabled ? .6 : 1,
            child: FlatButton(
              //Enable the button if we have enough points. Can do this by assigning a onPressed listener, or not.
              onPressed: isDisabled ? () {} : null,
              color: AppColors.orangeAccent,
              disabledColor: AppColors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Text("REDEEM", style: Styles.text(16, Colors.black, true)),
            ),
          ),
        )
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
  final String title;
  final int requiredPoints;

  DrinkData(
      this.title,
      this.requiredPoints,
      );
}

class DemoData {
  //how many points this user has earned, in a real app this would be loaded from an online service.
  int earnedPoints = 150;

  //List of available drinks
  List<DrinkData> drinks = [
    DrinkData("Coffee", 100),
    DrinkData("Tea", 150),
    DrinkData("Latte", 250),
    DrinkData("Frappuccino", 350),
    DrinkData("Pressed Juice", 450),
  ];
}


