import 'package:flutter/material.dart';

import 'model.dart';

class PlanetWidget extends StatefulWidget {
  final Planet planet;
  final bool currentlyInMainPos;

  const PlanetWidget({Key key, this.planet, this.currentlyInMainPos = false})
      : super(key: key);
  @override
  _PlanetWidgetState createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget>
    with TickerProviderStateMixin {
  final double constDiameter = 25.0;
  final double moonOrbitRadius = 20.0;
  AnimationController _rotationController;
  AnimationController _moonOrbitLengthController;

  @override
  void initState() {
    super.initState();
    _rotationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
  }

  @override
  void didUpdateWidget(PlanetWidget oldWidget) {
    if (widget.currentlyInMainPos != oldWidget.currentlyInMainPos) {
      _moonOrbitLengthController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Widget _buildCelestialBody({@required CelestialBody body}) {
    return Center(
      child: Container(
        width: body.diameter * constDiameter,
        height: body.diameter * constDiameter,
        decoration: BoxDecoration(
          color: body.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Planet planet = widget.planet;

    final List<Widget> bodies = [_buildCelestialBody(body: planet)];

    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Stack(
          overflow: Overflow.visible,
          children: bodies,
        ),
      ),
    );
  }
}
