import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/results.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class CategoryResults extends StatefulWidget {
  @override
  _CategoryResultsState createState() => _CategoryResultsState();
}

class _CategoryResultsState extends State<CategoryResults> {

  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String type;
  String key;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
    this.getJsonData();
  }


  void isSignedIN() async{
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
    });
  }

  Future<String> getJsonData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    key = sharedPreferences.getString('key');

    setState(() {
      type = key;
    });

    return "success";
  }
  @override
  Widget build(BuildContext context) {
    switch(type){
      case  'Men':return Visibility(
        visible: type==null?false:true,
        child: Container(
          color: Colors.blue.shade50,
          child:
          Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          staggeredTiles: [
            StaggeredTile.count(2, 1),
            StaggeredTile.count(1, 2),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(2, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
          ],
          children: <Widget>[
            Card(
                child:new InkWell(
                    onTap: ()async{
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString('type','category');
                      sharedPreferences.setString('key','Men');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                    },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Men\'s All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/mensall.jpg',
                        ),
                      ),
                    ),
                  ),
                )

                ),
            Card(
                child:new InkWell(
                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenClothing');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Clothing',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/mensclothing.jpg',
                        ),
                      ),
                    ),
                  ),
                )

            ),
            Card(
                child:new InkWell(
                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenFootwear');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Footwears',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/mensfootwear.jpg',
                        ),
                      ),
                    ),
                  ),
                )

            ),
            Card(
                child:new InkWell(
                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenWatches');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Watches',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/menswatch.jpg',
                        ),
                      ),
                    ),
                  ),
                )

            ),

            Card(
                child:new InkWell(
                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenPersonal Care');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child:  Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Personal Care',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/menspersonalcares.jpg',
                        ),
                      ),
                    ),
                  ),
                )

            ),
            Card(
                child:new InkWell(

                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenAccessories');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child: Container(
                  alignment: Alignment.bottomLeft,
                  child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                  Text('Accessories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                  decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      image: new AssetImage(
                        'images/men/mensaccessories.jpg',
                      ),
                    ),
                  ),
                ),)

            ),
            Card(
                child:new InkWell(
                  onTap: ()async{
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('type','subcategory');
                    sharedPreferences.setString('key','MenOthers');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                  },
                  child:  Container(
                    alignment: Alignment.bottomLeft,
                    child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                    Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage(
                          'images/men/mensothers.jpg',
                        ),
                      ),
                    ),
                  ),
                )
            ),
          ],
        )),
      ));

      case  'Women':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Women');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Women\'s All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womensall.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenClothing');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Clothing',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womensclothing.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenFootwear');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Footwears',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womensfootwear.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenWatches');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Watches',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womenswatch.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenPersonal Care');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Personal Care',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womenspersonalcares.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenAccessories');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Accessories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womenaccessories.png',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Jewellery');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Jewellery',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womenjewellery.jpg',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','WomenOthers');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/women/womensothers.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

              ],
            )),
          ));


      case  'Babies and Kids':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Babies and Kids');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/cats/babieshome.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Babies and KidsClothing');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Clothing',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/babyandkids/babyclothing.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Babies and KidsFootwear');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Footwears',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/babyandkids/babyfootwear.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Baby Care');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Baby Care',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/babyandkids/babylcares.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Toys');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Toys',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/babyandkids/toys.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Babies and KidsOthers');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/babyandkids/babyothers.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

              ],
            )),
          ));


      case  'Electronics':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(2, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Electronics');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/cats/electronics.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Mobiles');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Mobiles',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/mobiles.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Tablets');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Tablets',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/tablets.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Mobile Accessories');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Mobile Accessories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/mobileaccessories.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Laptops');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Laptops',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/laptop.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Desktop PCs');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Desktop PCs',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/computer.jpg',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Computer Accessories');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Computer Accessories',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/computeraccessories.jpg',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','ElectronicsOthers');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/electronics/speakers.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

              ],
            )),
          ));

      case  'Appliances':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Appliances');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images//cats/appliances.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','TV');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('TV',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/appliances/tv.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Washing Machines');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Washing Machines',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/appliances/washingmachine.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Air Conditioners');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Air Conditioners',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/appliances/ac.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Refrigerators');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Refrigerators',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/appliances/refregerator.jpeg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','AppliancesOthers');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/appliances/mixer.jpeg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

              ],
            )),
          ));

      case  'Home and Furniture':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Home and Furniture');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Home and Furnitures',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/cats/sofa.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Kitchen');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Kitchen',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/kitchen.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Dining');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Dining',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/dining.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Furniture');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Furniture',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/furniture.jpeg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Home Decor');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Home Decor',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/homedecor.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Lightning');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Lightning',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/homelighting.jpg',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Home and FurnitureOthers');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/home/homeothers.jpeg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

              ],
            )),
          ));

      case  'Others':return Visibility(
          visible: type==null?false:true,
          child: Container(
            color: Colors.blue.shade50,
            child:
            Padding(padding: const EdgeInsets.all(10.0),child:StaggeredGridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              staggeredTiles: [
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
              ],
              children: <Widget>[
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','category');
                        sharedPreferences.setString('key','Others');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('All',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/allothers.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Books');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Books',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/books.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Others');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Others',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/othersothers.JPG',
                            ),
                          ),
                        ),
                      ),)

                ),
                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Sports');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Sports',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/sports.jpeg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Gaming');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child:  Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Games',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/games.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),
                Card(
                    child:new InkWell(

                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','Automobile');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('Automobiles',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/car.jpg',
                            ),
                          ),
                        ),
                      ),)

                ),

                Card(
                    child:new InkWell(
                      onTap: ()async{
                        sharedPreferences = await SharedPreferences.getInstance();
                        sharedPreferences.setString('type','subcategory');
                        sharedPreferences.setString('key','School Supplies');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child:Padding(padding: const EdgeInsets.only(left:10.0),child:
                        Text('School Supplies',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor:  2.0,maxLines: 1,textAlign: TextAlign.center)),

                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                            image: new AssetImage(
                              'images/others/schoolsupplies.jpg',
                            ),
                          ),
                        ),
                      ),
                    )

                ),



              ],
            )),
          ));





      default:return Visibility(
        visible: type==null?false:true,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ),
        ),
      );




    }
  }
}
