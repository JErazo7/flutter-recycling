import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';


class ScreenCamera extends StatefulWidget {
  @override
  ScreenCameraState createState() {
    return ScreenCameraState();
  }
}

class ScreenCameraState extends State<ScreenCamera> with TickerProviderStateMixin{

  bool _multiPhotos = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(MediaQuery.of(context).size.width /9) ,bottomRight:Radius.circular(MediaQuery.of(context).size.width /9)  ),
                  color: Colors.blue,
                ),
                child: Camera(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      //TODO: Add Route navigator
                    },
                    child: Container(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.0125),
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.height * 0.125/3) ,bottomRight:Radius.circular(MediaQuery.of(context).size.height * 0.125/3)  ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Glass',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.0125,
                          ),
                          Text(
                            'Place in green bin',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.125/1.65,
                    ),
                    onPressed: (){
                      //TODO: Add a new Photo
                    },
                  ),
                  IconButton(
                    icon: _multiPhotos ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.125/1.65,
                    ) :
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.height * 0.125/1.65,
                    ),
                    onPressed: (){
                      //TODO: Take one or more fotos is the _multiPhotos is true
                      setState(() {
                        if(_multiPhotos == false){
                          _multiPhotos = true;
                        } else {
                          _multiPhotos = false;
                        }
                      });

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
      ),
        ),
    );
  }
}

class Camera extends StatefulWidget {
  @override
  CameraState createState(){
    return CameraState();
  }
}

class CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          //TODO: implement the API for the camera device
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.125/2,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.125/1.65,
              width: MediaQuery.of(context).size.height * 0.125/1.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.height * 0.125/6) ,bottomRight:Radius.circular(MediaQuery.of(context).size.height * 0.125/6)  ),
              ),
              child: Center(
                child:IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color:Colors.black ,
                  ),
                  onPressed: (){
                    //TODO: Route navigator back
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all( MediaQuery.of(context).size.height * 0.125/4),
              width: MediaQuery.of(context).size.height * 0.06*2,
              height: MediaQuery.of(context).size.height * 0.06*4,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height *0.03)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all( MediaQuery.of(context).size.height * 0.125/3.5),
              width: MediaQuery.of(context).size.height * 0.06*2,
              height: MediaQuery.of(context).size.height * 0.06*4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height *0.03)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all( MediaQuery.of(context).size.height * 0.125/3),
              width: MediaQuery.of(context).size.height * 0.06*2,
              height: MediaQuery.of(context).size.height * 0.06*4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.height *0.03)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}