import 'package:flutter/material.dart';

class Planet extends CelestialBody {
  Planet({
    String name,
    Color color,
    double diameter,
    String description,
    String intro,
    String formation,
    String history,
    String imgAssetPath,
    String vidAssetPath,
  }) : super(
          name: name,
          diameter: diameter,
          color: color,
          description: description,
          intro: intro,
          formation: formation,
          history: history,
          imgAssetPath: imgAssetPath,
          vidAssetPath: vidAssetPath,
        );
}

class CelestialBody {
  final String name;
  final double diameter;
  final Color color;
  final String description;
  final String intro;
  final String formation;
  final String history;
  final String imgAssetPath;
  final String vidAssetPath;

  CelestialBody({
    @required this.name,
    @required this.diameter,
    @required this.color,
    this.description,
    this.intro,
    this.formation,
    this.history,
    this.imgAssetPath,
    this.vidAssetPath,
  });
}
