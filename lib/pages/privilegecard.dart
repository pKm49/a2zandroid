import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
//appspecific imports
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/cardaddresspage.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/searchresults.dart';



class PrivilegeCard extends StatefulWidget {
  @override
  _PrivilegeCardState createState() => _PrivilegeCardState();
}

class _PrivilegeCardState extends State<PrivilegeCard> {

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

  void isSignedIN() async{

    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
    });

    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;



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
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('A2Z Privilege Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('        Purchase A2Z Privilege card to avail maximum amount of discount as decided by the A2Z Online Shoppy and tie up institutions/organisation and free general accident insurance (25,000 to 200,000) from NEW INDIA ASSURANCE COMPANY and ORIENTAL INSURANCE COMPANY. ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Terms and Conditions',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline),textAlign: TextAlign.center,textScaleFactor: 1.2,),),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('* Minimum 24 hours admit in hospital\n*Original hospital documents, Bills & Discharge Summary\n *Road accidents FIR attested copy\n*Death certificate\n*Postmortem Report\n*Privilege Card Copy\n*Identity Card Copy\n *Bank Details Copy',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),

          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Silver Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(6.0),child:
          new Image.asset('images/cards/silver.jpg',height: MediaQuery.of(context).size.height *.30,)

          ),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('  Silver privilege card discounts avail maximum amount of discount as decided by the tie up institutions or organisation in A2Z@HOME partners and free general accident insurance coverage(50,000 death coverage 25,000 hospitalized expense) from NEW INDIA ASSURANCE COMPANY LTD In Palakkad Branch. ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(10.0),child: ButtonTheme(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                buycard("Silver");
              },
              child: new Text("Purchase Now (₹500)",textScaleFactor: 1.2,),
            ),
          )
          ),


          new Padding(padding: const EdgeInsets.only(top:100.0,bottom: 8.0,right: 8.0,left: 8.0),
            child: new Text('Gold Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(6.0),child:
          new Image.asset('images/cards/gold.jpg',height: MediaQuery.of(context).size.height *.30,)

          ),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('   Gold privilege card discounts avail maximum amount of discount as decided by the tie up institutions or organisation in A2Z@HOME partners and free general accident insurance coverage(100,000) from ORIENTAL INSURANCE COMPANY LTD In Pattambi Branch. ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(10.0),child: ButtonTheme(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                buycard("Gold");
              },
              child: new Text("Purchase Now (₹700)",textScaleFactor: 1.2,),
            ),
          )
          ),



          new Padding(padding: const EdgeInsets.only(top:100.0,bottom: 8.0,right: 8.0,left: 8.0),
            child: new Text('Platinum Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(6.0),child:
          new Image.asset('images/cards/platinum.jpg',height: MediaQuery.of(context).size.height *.30,)

          ),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('    Platinum privilege card discounts avail maximum amount of discount as decided by the tie up institutions or organisation in A2Z@HOME partners and free general accident insurance coverage(200,000 death coverage and 200,000 Hospitalized expense) from ORIENTAL INSURANCE COMPANY LTD In Thiruvanathapuram Branch.   ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(10.0),child: ButtonTheme(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                buycard("Platinum");
              },
              child: new Text("Purchase Now (₹900)",textScaleFactor: 1.2,),
            ),
          )
          ),

          new Padding(padding: const EdgeInsets.only(top:100.0,bottom: 8.0,right: 8.0,left: 8.0),
            child: new Text('Diamond Card',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.3,),),
          new Padding(padding: const EdgeInsets.all(6.0),child:
          new Image.asset('images/cards/diamond.jpg',height: MediaQuery.of(context).size.height *.30,)
          ),
          new Padding(padding: const EdgeInsets.all(10.0),child: Text('     Family privilege card discounts avail maximum amount of discount as decided by the tie up institutions or organisation in A2Z@HOME partners and free general accident insurance coverage(200,000 death coverage(50,000*4 person\'s in own family only),(25,000*4 person\'s in own family only) and 100,000 Hospitalized expense)from from NEW INDIA ASSURANCE COMPANY LTD In Palakkad Branch.  ',textAlign: TextAlign.justify,textScaleFactor: 1.25,)),
          new Padding(padding: const EdgeInsets.all(10.0),child: ButtonTheme(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            minWidth: 200.0,
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                buycard("Diamond");
              },
              child: new Text("Purchase Now (₹1300)",textScaleFactor: 1.2,),
            ),
          )
          ),


        ],
      ),
    );
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
  void buycard(String card) async{

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
          final String urladd = 'https://www.a2zonlineshoppy.com/api/cardpurchase/$card';

          var response = await http.get(
            Uri.encodeFull(urladd),
            headers: heaaders,
          );

          print(response.body);
          var bod = json.decode(response.body);
          String message = bod["message"];

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
            String status = bod["status"];

            if(status == "already"){
              Navigator.of(context).pop();

              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Warning'),
                    content: Text("You already purchased a privilege card"),
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
              var cards = bod["card"][0];
              print("card");
              print(cards);
              String card = json.encode(cards);
              sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString("card", card);
              Navigator.of(context).pop();

              Navigator.push(context, MaterialPageRoute(builder: (context)=> CardAddressPage()) );

            }
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
}
