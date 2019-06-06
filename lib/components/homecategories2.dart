import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/category.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeCategories2 extends StatelessWidget {

  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    Widget homecat = Column(
      children: <Widget>[

        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Categor(
                  image_loc: 'images/cats/babieshome.jpg',
                  image_caption: 'Babies and Kids',
                  type: 'category',
                  keey: 'Babies and Kids',
                  height: 220.0,
                )
            )

          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child:   Categor(
                  image_loc: 'images/cats/appliances.jpg',
                  image_caption: 'Appliances',
                  type: 'category',
                  keey: 'Appliances',
                  height: 150.0,
                ),

            ),
            Expanded(
              flex: 1,
              child:   Categor(

                image_loc: 'images/cats/others.jpeg',
                image_caption: 'Others',
                type: 'category',
                keey: 'Others',
                height: 150.0,
              ),

            ),
          ],
        ),
      ],
    );
    return homecat;
  }
}


class Categor extends StatelessWidget {
  final String image_loc;
  final String image_caption;
  final String type;
  final String keey;
  final double height;

  Categor({
    this.image_caption,
    this.image_loc,
    this.type,
    this.keey,
    this.height
});

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.all(5.0),
    child: Card(
      child: Container(
          height: height,
          child:new InkWell(
            onTap: ()async{
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString('type',type);
              sharedPreferences.setString('key',keey);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Category()) );
            },
            child:  Container(
              alignment: Alignment.bottomLeft,
              child:Padding(padding: const EdgeInsets.only(left:10.0),child:
              Text('$image_caption',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

              decoration: new BoxDecoration(
                color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: new AssetImage(
                    '$image_loc',
                  ),
                ),
              ),
            ),
          )

      ),
    ),
    );
  }
}
