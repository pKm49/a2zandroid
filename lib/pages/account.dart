/// ListTile

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/authentication/login.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {

  SharedPreferences sharedPreferences;
  String name,mobile,email,userdata,address,deladdress;
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  Map<String, String> heaaders = {};
  final TextEditingController _filter = new TextEditingController();
  String cook ;
  String tock ;
  String csrf ;
  String _searchText = "";
  var data;
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
      userdata = sharedPreferences.getString('userdata');
      cook = sharedPreferences.getString('Cookie');
      tock = sharedPreferences.getString('tocken');
      csrf = sharedPreferences.getString('csrf');


      if(tock!=null){
        heaaders['authorization'] = "tocken "+tock;
      }

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;


      print(sharedPreferences.getString('userdata'));
      data = json.decode(userdata);
      print("data");
      print(data["_id"]);
      email=data["email"];

      if(data["address"][0]["house"]=="Enter "){
        address = "Edit your home address!";
      }else{
        address=data["address"][0]["house"]+"\n"+data["address"][0]["postoffice"]+"\n"+data["address"][0]["district"]+"\n"+data["address"][0]["state"]+"\n"+data["address"][0]["pincode"];
      }
      if(data["deladdress"][0]["house"]=="Enter "){
        deladdress = "Edit your delivery address!";
      }else{
        address=data["deladdress"][0]["house"]+"\n"+data["deladdress"][0]["postoffice"]+"\n"+data["deladdress"][0]["district"]+"\n"+data["deladdress"][0]["state"]+"\n"+data["deladdress"][0]["pincode"];
      }

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
   /*
    final String urladd = 'https://www.a2zonlineshoppy.com/api/searchproducts';
    dynamic mybody = {'search': '$key','_csrf':'$csrf'};


    var response = await http.post(
        Uri.encodeFull(urladd),
        headers: heaaders,
        body:mybody
    );
    print(response.body);

    var bod = json.decode(response.body);
    var message = bod["message"];
    var products = bod["products"];


    print("addtocart");
    print(message);

    if(message=="error"){
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
      print("products");
      print(products);
      print("product length");
      print(products.length);

    }
    */

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
          Container(
            height: MediaQuery.of(context).size.height *.45,
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(padding: const EdgeInsets.only(top:25.0),child:
                Icon(Icons.account_circle,color: Colors.white,size:MediaQuery.of(context).size.height *.3),),
            Padding(padding: const EdgeInsets.only(top:25.0),child:
            name == null?
            Text('Guest User',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,textScaleFactor: 1.5,):
      Text('$name',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,textScaleFactor: 1.5,)),
    ],

            ),
          ),
          Visibility(
            visible: name == null?true:false,
            child: Container(
              height: MediaQuery.of(context).size.height *.45,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top:30.0),child:
                  Text('oops! you are not logged in',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.5,)),
                  Padding(padding: const EdgeInsets.only(top:30.0),child:
                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()) );
                    },
                    child:Text('Login here',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),textAlign: TextAlign.center,textScaleFactor: 1.3,))
                    ,
                  )
                ],

              ),
            ),
          ),
          Visibility(
            visible: name == null?false:true,
            child:
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height *.45,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top:25.0),child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.phone_android,color: Colors.blue),
                        Text(' $mobile',textAlign: TextAlign.center,textScaleFactor: 1.3,)

                      ],
                    ),

                  ),


                ],

              ),
            ),
          )

        ],
      ),
    );
  }
}




