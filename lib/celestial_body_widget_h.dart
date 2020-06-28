import 'package:flutter/material.dart';

class CelestialBodyWidgeth extends StatelessWidget {
  final String imagePath;

  const CelestialBodyWidgeth(this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter ,
            end: Alignment.topCenter,
            colors: <Color>[
              Colors.transparent,
              Colors.black45,
              Colors.black.withOpacity(0.65),
              Colors.black87,
              Colors.black
            ],
          ),
        ),
        child: RotatedBox(
          quarterTurns: 10,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
