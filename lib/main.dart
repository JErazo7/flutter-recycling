import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recycling/planet_page.dart';

import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: PlanetPage(
          currentPlanet: Planet(
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
          ),
        )));
  }
}
