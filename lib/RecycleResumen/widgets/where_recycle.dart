import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class WhereRecycle extends StatefulWidget {
  @override
  _WhereRecycleState createState() => _WhereRecycleState();
}

class _WhereRecycleState extends State<WhereRecycle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => MapsLauncher.launchQuery('Recycling Center'),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
              border: Border.all(color: Colors.black12)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 20, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Where to recycle?',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Icon(
                      Icons.map,
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
