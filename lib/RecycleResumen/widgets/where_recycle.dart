import 'package:flutter/material.dart';
import 'package:flutter_recycling/RecycleResumen/widgets/location_item.dart';
import 'package:flutter_recycling/RecycleResumen/widgets/location_item_properties.dart';

import 'location_data.dart';

class WhereRecycle extends StatefulWidget {
  @override
  _WhereRecycleState createState() => _WhereRecycleState();
}

class _WhereRecycleState extends State<WhereRecycle> {

  LocationItemProperties _locationItemProperties;

  void getProperties (index) {
    setState(() {
      _locationItemProperties = LocationItemProperties(locationData: LocationData.getAll()[index]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationItemProperties = LocationItemProperties(locationData: LocationData.getAll()[0]);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.9,
        builder: (context,scrollController) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
                border: Border.all(
                    color: Colors.black12
                )
            ),
            child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Where to recycle',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),
                          ),
                          Icon(Icons.arrow_upward)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 300,
                      child: LocationItem(properties: getProperties),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: _locationItemProperties,
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}
