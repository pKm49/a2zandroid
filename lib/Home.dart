import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//appspecific imports
import 'package:http/http.dart' as http;

import 'package:a2zonlinshoppy/components/banner1.dart';
import 'package:a2zonlinshoppy/components/banner2.dart';
import 'package:a2zonlinshoppy/components/banner3.dart';
import 'package:a2zonlinshoppy/components/banner4.dart';
import 'package:a2zonlinshoppy/components/homecategories.dart';
import 'package:a2zonlinshoppy/components/homecategories2.dart';
import 'package:a2zonlinshoppy/components/homecategories3.dart';
import 'package:a2zonlinshoppy/components/homemobiles.dart';
import 'package:a2zonlinshoppy/components/homeofferzone.dart';
import 'package:a2zonlinshoppy/components/homerecentadded.dart';
import 'package:a2zonlinshoppy/components/hometoprated.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'pages/privilegecard.dart';
import 'components/drawer.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeMobiles homeMobiles = new HomeMobiles();
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  Map<String, String> heaaders = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onSubmitted: searchresults,
          style: new TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade50),
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search,color: Colors.white);
        this._appBarTitle = new Text('A2ZOnlineShoppy');

      }
    });
  }
  void searchresults(String key) async {

    sharedPreferences.setString('searchkey',key);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

  }


  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }



  void isSignedIN() async{

    final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');

    check().then((intenet) async{
      if (intenet != null && intenet) {
        print("Internet connected");
      }else{
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("Check Your Internet Connection and try again."),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          },
        );
      }

      // No-Internet Case
    });

  }

  void updateCookie(http.Response response) async{
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      sharedPreferences.setString('Cookie', (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
    var bod = json.decode(response.body);
    String csrf = bod["csrf"];
    sharedPreferences.setString("csrf",csrf);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.red,
        title: _appBarTitle,
        actions: <Widget>[
          new IconButton(icon:_searchIcon, onPressed: (){
            _searchPressed();
          }),
          new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()) );

          })
        ],
      ),

      drawer: new Drawer(
        child: AtozDrawer(),
      ),

      //Body
      body: new ListView(
        children: <Widget>[
          Card(
            child:
            Banner1(),
          ),
          new Padding(padding: const EdgeInsets.all(5.0),child: HomeCategories()),


          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Best Mobile Phones',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          //gridview for prducts
          new Padding(padding: const EdgeInsets.only(top:5.0,bottom: 5.0),child:
          Container(
            color: Colors.blue.shade300,
            height: 270.0,
            child: homeMobiles,
          ),),
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Purchase Our Privilege Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(6.0),child:
            new Image.asset('images/cards/showcard.jpg',height: MediaQuery.of(context).size.height *.30,)
            ,),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('        Purchase A2Z Privilege card to avail maximum amount of discount as decided by the A2Z Online Shoppy and tie up institutions/organisation and free general accident insurance (25,000 to 200,000) from NEW INDIA ASSURANCE COMPANY and ORIENTAL INSURANCE COMPANY. ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(10.0),child: ButtonTheme(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivilegeCard()) );
              },
              child: new Text("Read More",textScaleFactor: 1.2,),
            ),
          )
          ),
          Card(
            child:
            Banner2(),
          ),
          new Padding(padding: const EdgeInsets.all(5.0),child: HomeCategories2()),

          new Padding(padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
            child: new Text('Offer Offer Offer!',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          //gridview for prducts
          new Padding(padding: const EdgeInsets.all(5.0),child:
          Container(
            color: Colors.blue.shade300,
            height: 290.0,
            child: HomeOfferZone(),
          ),),
          Card(
            child:
            Banner3(),
          ),
          new Padding(padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
            child: new Text('Latest Products, JUST IN!',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          //gridview for prducts
          new Padding(padding: const EdgeInsets.all(5.0),child:
          Container(
            color: Colors.blue.shade300,
            height: 290.0,
            child: HomeRecentAdded(),
          ),),
          Card(
            child:
            Banner4(),
          ),
          new Padding(padding: const EdgeInsets.all(5.0),child: HomeCategories3()),

          new Padding(padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
            child: new Text('Best Products at Best Price',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          //gridview for prducts
          new Padding(padding: const EdgeInsets.all(5.0),child:
          Container(
            color: Colors.blue.shade300,
            height: 290.0,
            child: HomeTopRated(),
          ),),


        ],
      ),
    );
  }
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

