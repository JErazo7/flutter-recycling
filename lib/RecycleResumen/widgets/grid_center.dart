import 'package:flutter/material.dart';

class GridCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30
    );

    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('250', style: numStyle,),
                  Text('Plastic')
                ],
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey,
              ),
              Column(
                children: [
                  Text('250', style: numStyle,),
                  Text('Glass')
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.grey,
                height: 1,
                width: 90,
              ),
              Container(
                color: Colors.grey,
                height: 1,
                width: 90,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('250', style: numStyle,),
                  Text('Paper')
                ],
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey,
              ),
              Column(
                children: [
                  Text('250', style: numStyle,),
                  Text('Metal')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
