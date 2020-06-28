import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final List<Widget> imageSliders = imgList.map((item) => Container(
    padding: EdgeInsets.all(10),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      elevation: 5,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item.image, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                   item.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
          ),
        ]
    );
  }
}

final List<ImageObject> imgList = [
  ImageObject('Plastico', 'https://ichef.bbci.co.uk/news/410/cpsprodpb/C6DF/production/_97011905_gettyimages-103583960-1.jpg'),
  ImageObject('Metal', 'https://previews.123rf.com/images/monticello/monticello1504/monticello150400018/39146029-basura-reciclable-que-consiste-en-vidrio-pl%C3%A1stico-metal-y-papel-aisladas-sobre-fondo-blanco.jpg',),
  ImageObject('Papel', 'https://i.ytimg.com/vi/f9BINEPtCoA/hqdefault.jpg',)
];

class ImageObject {
  final String name;
  final String image;

  ImageObject(this.name, this.image);
}