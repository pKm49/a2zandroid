import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Banner3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget banner3 = new Container(
        color: Colors.grey.shade400,
        child: CarouselSlider(
          viewportFraction: 1.0,
          height:MediaQuery.of(context).size.height *.23,
          autoPlay: true,
          items: <Widget>[
            Card(
              child: new CachedNetworkImage(
                imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner3image1.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            Card(
              child: new CachedNetworkImage(
                imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner3image2.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            Card(child:
            new CachedNetworkImage(
              imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner3image3.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),),
            Card(child:
            new CachedNetworkImage(
              imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner3image4.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ))
          ],
        )
    );
    return banner3;
  }
}
