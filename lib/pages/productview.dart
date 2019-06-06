import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports
import 'package:share/share.dart';

import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/pages/addresspage.dart';
import 'package:a2zonlinshoppy/pages/useraddresspage.dart';
import 'package:a2zonlinshoppy/components/singleproductview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/searchresults.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String cook ;
  String tock ;
  String size ;
  String color ;
  String csrf ;
  String cod ;
  String products ;
  String quantity ;
  String productid ;
  Map<String, String> heaaders = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

    });
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



  void share() async{

    sharedPreferences = await SharedPreferences.getInstance();
    productid = sharedPreferences.getString('productId');

    Share.share('Hey, Check out this product on A2ZOnlineShoppy! https://www.a2zonlineshoppy.com/product/getproduct/$productid');


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


  void addtocart() async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  new Dialog(
            child:  Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child:
                Center(
                  child: CircularProgressIndicator(),
                )
            ),
          );
        }
    );

    check().then((intenet) async{
      if (intenet != null && intenet) {
          final String urladd = 'https://www.a2zonlineshoppy.com/api/addtocart';
          String message1 = "";
          String message2 = "";
          String message3 = "";
          sharedPreferences = await SharedPreferences.getInstance();
          cook = sharedPreferences.getString('Cookie');
          tock = sharedPreferences.getString('tocken');
          size = sharedPreferences.getString('size');
          color = sharedPreferences.getString('color');
          csrf = sharedPreferences.getString('csrf');
          quantity = sharedPreferences.getString('quantity');
          productid = sharedPreferences.getString('productId');
          print("cookiesproduct");
          print(cook);
          if(size == null){
            message1 = "size can't be empty";
          }else{
            message1 = "ok";
          }

          if(color == null){
            message2 = "color can't be empty";
          }else{
            message2 = "ok";
          }

          if(quantity == null){
            quantity = '1';
          }

          if(tock!=null){
            heaaders['authorization'] = "tocken "+tock;
          }

          heaaders['Accept'] = "application/JSON";
          heaaders['Cookie'] = cook;

          if(message1 == "ok" && message2 =="ok"){
            dynamic mybody = {'size': '$size','color': '$color', 'qty': '$quantity', 'id': '$productid','_csrf':'$csrf'};

            print('size');
            print('$size');
            print('color');
            print('$color');
            print('quantity');
            print('$quantity');
            print('id');
            print('$productid');

            var response = await http.post(
                Uri.encodeFull(urladd),
                headers: heaaders,
                body:mybody
            );

            print(response.body);

            var bod = json.decode(response.body);
            var message = bod["message"];


            print("addtocart");
            print(message);

            if(message=="error"){
              Navigator.of(context).pop();

              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(


                    title: Text('Error'),
                    content: Text("Something went wrong, try again."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }else{
              Navigator.of(context).pop();

              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text("Added to cart Successfully!"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }

          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Empty Fields'),
                  content: Text(message1+"\n"+message2),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );

        }
      }else{
        Navigator.of(context).pop();

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
                    Navigator.of(context).pop();
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


  void buynow() async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  new Dialog(
            child:  Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child:
                Center(
                  child: CircularProgressIndicator(),
                )
            ),
          );
        }
    );

    check().then((intenet) async{
      if (intenet != null && intenet) {
          final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
          String message1 = "";
          String message2 = "";
          String message3 = "";
          sharedPreferences = await SharedPreferences.getInstance();
          cook = sharedPreferences.getString('Cookie');
          tock = sharedPreferences.getString('tocken');
          size = sharedPreferences.getString('size');
          color = sharedPreferences.getString('color');
          csrf = sharedPreferences.getString('csrf');
          quantity = sharedPreferences.getString('quantity');
          productid = sharedPreferences.getString('productId');

          print("csrf");
          print(csrf);

          print("cook");
          print(cook);

          print("tock");
          print(tock);

          if(size == null){
            message1 = "size can't be empty";
          }else{
            message1 = "ok";
          }

          if(color == null){
            message2 = "color can't be empty";
          }else{
            message2 = "ok";
          }

          if(quantity == null){
            quantity = '1';
          }

          if(tock!=null){
            heaaders['authorization'] = "tocken "+tock;
          }

          heaaders['Accept'] = "application/JSON";
          heaaders['Cookie'] = cook;

          if(message1 == "ok" && message2 =="ok"){
            dynamic mybody = {'size': '$size','color': '$color', 'qty': '$quantity', 'id': '$productid', '_csrf': '$csrf'};

            var response = await http.post(
                Uri.encodeFull(urlbuy),
                headers: heaaders,
                body:mybody
            );

            print(response.body);

            var bod = json.decode(response.body);
            String message = bod["message"];

            print("buynow");
            print(bod);

            if(message=="error"){
              Navigator.of(context).pop();

              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text("Something went wrong, try again."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }else if((message=="success")){
              setState(() {
                cod = bod["cod"].toString();
                products = json.encode(bod["products"]);
              });

              print("codelivey");
              print(cod);

              print("productsare");
              print(products);

              sharedPreferences.setString('cod',cod);
              sharedPreferences.setString('products',products);

              if(name == null){
                Navigator.of(context).pop();

                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressPage()) );
              }else{
                Navigator.of(context).pop();

                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAddressPage()) );
              }

            }

          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Empty fields'),
                  content: Text(message1+"\n"+message2),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

      }else{
        Navigator.of(context).pop();

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
                    Navigator.of(context).pop();
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


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        child:Scaffold(
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
          body:  new Padding(padding: const EdgeInsets.only(top:5.0,bottom:0.0),child: SingleProductView()),
          bottomNavigationBar:
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:
                ButtonTheme(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  minWidth: 100.0,
                  height: 50.0,
                  child:
                  new Padding(padding: const EdgeInsets.all(5.0),child:
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: (){
                        buynow();
                      },
                      child: Text('Buy Now',textAlign: TextAlign.center,textScaleFactor: 1.2,)
                  )),
                ),),
              Expanded(
                flex: 2,
                child:
                ButtonTheme(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  minWidth: 100.0,
                  height: 50.0,
                  child:
                  new Padding(padding: const EdgeInsets.all(5.0),child:
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: (){
                        addtocart();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Icon(Icons.add_shopping_cart),)
                        ],
                      )
                  ),),
                ),),
              Expanded(
                flex: 1,
                child:
                ButtonTheme(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  minWidth: 100.0,
                  height: 50.0,
                  child:
                  new Padding(padding: const EdgeInsets.all(5.0),child:
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: (){
                        share();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Icon(Icons.share),)
                        ],
                      )
                  ),),
                ),)
            ],
          ),
        )
        , onWillPop: requestPop);
  }

  Future<bool> requestPop() async {
    print("helloooooo");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('quantity');
      sharedPreferences.remove('color');
      sharedPreferences.remove('size');
      return true;
    }

}

