import 'package:flutter/material.dart';
import 'package:flutter_recycling/RecycleResumen/widgets/where_recycle.dart';
import 'package:flutter_recycling/planet_page.dart';
import 'widgets/grid_center.dart';
import 'package:animated_background/animated_background.dart';

import 'widgets/carousel_indicator.dart';

class RecycleResumen extends StatefulWidget {
  @override
  _RecycleResumenState createState() => _RecycleResumenState();
}

class _RecycleResumenState extends State<RecycleResumen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Recycled items',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.close,
            size: MediaQuery.of(context).size.width * 0.09,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlanetPage()),
            );
          },
        ),
      ),
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
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: CarouselWithIndicatorDemo(),
                          ),
                        ),
                      ),
                      Expanded(flex: 4, child: GridCenter()),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          height: 0.17 * MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: WhereRecycle()))
                ],
              ))),
    );
  }
}
