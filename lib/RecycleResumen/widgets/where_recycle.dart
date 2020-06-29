import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';


class WhereRecycle extends StatefulWidget {
  @override
  _WhereRecycleState createState() => _WhereRecycleState();
}

class _WhereRecycleState extends State<WhereRecycle> {

  @override

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.1,
        builder: (context,scrollController) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(55, 59, 68, 1),
                    Color.fromRGBO(66, 134, 244, 1),

                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
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
                      padding: const EdgeInsets.only(top: 15, left: 20, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Where to recycle',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),
                          ),
                          IconButton(
                            hoverColor: Colors.blue,
                            autofocus: true,
                            icon: Icon(Icons.arrow_forward, color: Colors.white,),
                            onPressed: () => MapsLauncher.launchQuery('Recycling Center'),
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        }
    );
  }
}
