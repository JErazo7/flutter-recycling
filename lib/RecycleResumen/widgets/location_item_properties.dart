import 'package:flutter/material.dart';
import 'package:flutter_recycling/RecycleResumen/widgets/location_data.dart';


class LocationItemProperties extends StatelessWidget {
  final LocationData locationData;

  const LocationItemProperties({Key key, this.locationData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            border: Border.all(
                color: Colors.black12
            )
        ),
        height: 400,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  locationData.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 30
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Address',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  locationData.address,
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                width: 150,
                margin: EdgeInsets.symmetric(horizontal: 20 ),
                child: Material(
                  borderRadius:  BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                  elevation: 5,
                  child: InkWell(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                    onTap: () => print('hola'),
                    child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(Icons.location_on)
                    ),
                  ),
                )
            )
          ],
        )
    );
  }
}
