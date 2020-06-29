import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_recycling/RecycleResumen/recycle_resumen.dart';

import 'custom_page_routes.dart';

class ScreenCamera extends StatefulWidget {
  @override
  ScreenCameraState createState() {
    return ScreenCameraState();
  }
}

class ScreenCameraState extends State<ScreenCamera>
    with TickerProviderStateMixin {
  int pos = 0;
  List<MaterialModel> photos = [
    MaterialModel('Glass', 'Place in green bin', 'assets/vaso.jpg!d'),
    MaterialModel('Plastic', 'Place in green bin', 'assets/plastico.jpg'),
    MaterialModel('Metal', 'Place in green bin', 'assets/cadena.jpg!d'),
    MaterialModel('Paper', 'Place in green bin', 'assets/papel.JPG')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Camera(
                  photo: photos[pos].image,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.0125),
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                MediaQuery.of(context).size.height * 0.125 / 3),
                            bottomRight: Radius.circular(
                                MediaQuery.of(context).size.height *
                                    0.125 /
                                    3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            photos[pos].name,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Text(
                            photos[pos].site,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize:
                          MediaQuery.of(context).size.height * 0.125 / 1.65,
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.125 / 1.65,
                      ),
                      onPressed: () {
                        setState(() {
                          pos = pos == 3 ? 0 : pos + 1;
                        });
                      },
                    ),
                    IconButton(
                      iconSize:
                          MediaQuery.of(context).size.height * 0.125 / 1.65,
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height * 0.125 / 1.65,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MyPageRoute(
                          transDuation: Duration(milliseconds: 600),
                          builder: (BuildContext context) {
                            return RecycleResumen();
                          },
                        ));
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        )));
  }
}

class Camera extends StatelessWidget {
  final String photo;

  const Camera({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(MediaQuery.of(context).size.width / 9),
                  bottomRight:
                      Radius.circular(MediaQuery.of(context).size.width / 9)),
              child: Image.asset(
                photo,
                fit: BoxFit.cover,
              )),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.125 / 2,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.125 / 1.65,
              width: MediaQuery.of(context).size.height * 0.125 / 1.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.height * 0.125 / 6),
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.height * 0.125 / 6)),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MaterialModel {
  final name;
  final site;
  final image;

  MaterialModel(this.name, this.site, this.image);
}
