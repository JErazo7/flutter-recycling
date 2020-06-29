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
      padding: EdgeInsets.fromLTRB(60, 0, 60, 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Recycling points', style: numStyle.copyWith(color: Colors.white),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
             Material(
               borderRadius: BorderRadius.all(Radius.circular(15.0)),
               elevation: 3,
               child:  Container(
                 padding: EdgeInsets.all(20),
                 width: MediaQuery.of(context).size.width /4,
                 child: Column(
                   children: [
                     Text('250', style: numStyle,),
                     Text('Glass')
                   ],
                 ),
               ),
             ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey,
              ),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                borderOnForeground: true,
                elevation: 3,
                child:  Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width /4,
                  child: Column(
                    children: [
                      Text('250', style: numStyle,),
                      Text('Paper')
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                elevation: 3,
                child:  Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width /4,
                  child: Column(
                    children: [
                      Text('250', style: numStyle,),
                      Text('Plastic')
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey,
              ),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                elevation: 3,
                child:  Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width /4,
                  child: Column(
                    children: [
                      Text('250', style: numStyle,),
                      Text('Metal')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
