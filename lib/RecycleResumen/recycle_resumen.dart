import 'package:flutter/material.dart';
import 'package:flutter_recycling/RecycleResumen/widgets/where_recycle.dart';
import 'widgets/grid_center.dart';

import 'widgets/carousel_indicator.dart';

class RecycleResumen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight:  Radius.circular(40))
                  ),
                  child: CarouselWithIndicatorDemo(),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridCenter(),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
          WhereRecycle()
        ],
      )
    );
  }
}

