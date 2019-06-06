import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/components/billdetails.dart';
import 'package:a2zonlinshoppy/pages/orderconfirmed.dart';
import 'package:a2zonlinshoppy/pages/paymentgateway.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock;
  Map<String, String> heaaders = {};
  bool codenable,cod,sameasshipping = true;
  var pgproducts;


  String fullnamecontroller;
  String fullnamecontrollerbill;
  int mobilecontroller;
  int mobilecontrollerbill;
  String emailcontroller;
  String emailcontrollerbill;
  String housecontroller;
  String housecontrollerbill;
  String postofficecontroller;
  String postofficecontrollerbill;
  String nearesttowncontroller;
  String nearesttowncontrollerbill;
  String districtcontroller;
  String districtcontrollerbill;
  String statecontroller;
  String statecontrollerbill;
  int pincontroller;
  int pincontrollerbill;

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


    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
    String code = sharedPreferences.getString('codenable');

    if(code=="true"){
      codenable=true;
    }else{
      codenable=false;
    }

    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');

    String pgprods = sharedPreferences.getString('pgproducts');

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

      pgproducts = json.decode(pgprods);

      fullnamecontroller= pgproducts["deladdress"][0]["name"];
      housecontroller= pgproducts["deladdress"][0]["house"];
      postofficecontroller= pgproducts["deladdress"][0]["postoffice"];
      nearesttowncontroller=pgproducts["deladdress"][0]["city"];
      districtcontroller=pgproducts["deladdress"][0]["district"];
      statecontroller=pgproducts["deladdress"][0]["state"];
      pincontroller=pgproducts["deladdress"][0]["pincode"];
      mobilecontroller=pgproducts["deladdress"][0]["mob"];
      emailcontroller=pgproducts["deladdress"][0]["email"];

      fullnamecontrollerbill= pgproducts["billaddress"][0]["name"];
      housecontrollerbill= pgproducts["billaddress"][0]["house"];
      postofficecontrollerbill= pgproducts["billaddress"][0]["postoffice"];
      nearesttowncontrollerbill=pgproducts["billaddress"][0]["city"];
      districtcontrollerbill=pgproducts["billaddress"][0]["district"];
      statecontrollerbill=pgproducts["billaddress"][0]["state"];
      pincontrollerbill=pgproducts["billaddress"][0]["pincode"];
      mobilecontrollerbill=pgproducts["billaddress"][0]["mob"];
      emailcontrollerbill=pgproducts["billaddress"][0]["email"];
    });

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

  }




  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    child: Scaffold(
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
      body:  Container(
        height:MediaQuery.of(context).size.height *1.0 ,
        child: ListView(
            children: <Widget>[
              Visibility(
                visible:true,
                child: new Padding(padding: const EdgeInsets.all( 20.0),child:
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 20.0,left:10.0),child:
                      Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 1.4,style: TextStyle(fontWeight: FontWeight.bold),)),
                      new Padding(padding: const EdgeInsets.all( 10.0),child:
                      Text("$fullnamecontroller \n $housecontroller \n $postofficecontroller \n $nearesttowncontroller \n"+
                        "$districtcontroller \n $statecontroller \n $pincontroller \n +91$mobilecontroller \n $emailcontroller"
                        ,textAlign: TextAlign.start,textScaleFactor: 1.2)),
                     ],
                  ),
                  )
                ),
              ),

              Visibility(
                visible:true,
                child: new Padding(padding: const EdgeInsets.all( 20.0),child:
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 20.0,left:10.0),child:
                      Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 1.4,style: TextStyle(fontWeight: FontWeight.bold),)),
                      new Padding(padding: const EdgeInsets.all( 10.0),child:
                      Text("$fullnamecontrollerbill \n $housecontrollerbill \n $postofficecontrollerbill \n $nearesttowncontrollerbill \n"+
                          "$districtcontrollerbill \n $statecontrollerbill \n $pincontrollerbill \n +91$mobilecontrollerbill \n $emailcontrollerbill"
                        ,textAlign: TextAlign.start,textScaleFactor: 1.2)),
                    ],
                  ),
                )
                ),
              ),

              Visibility(
                visible:true,
                child: new Padding(padding: const EdgeInsets.all( 20.0),child:
                Card(
                  child: BillDetails(),
                )
                ),
              ),

              new Padding(padding: const EdgeInsets.only(top: 20.0,left:10.0),child:
              Text("(All price include tax)",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),)),

              new Padding(padding: const EdgeInsets.all(20.0),child:
              ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: (){
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
                    payment();
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text("Check Out",textScaleFactor: 1.2,),
                ),
              )
              ),

            ]
        ),
      )

    )
        , onWillPop: requestPop);





}

  Future<bool> requestPop() async {
    print("helloooooo");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('codenable');
    sharedPreferences.remove('codproducts');
    sharedPreferences.remove('pgproducts');

    return true;
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

  void payment()async{



    check().then((intenet) async{
      if (intenet != null && intenet) {

          final String urlbuy = 'https://www.a2zonlineshoppy.com/api/paymentgateway';

          var response = await http.get(
            Uri.encodeFull(urlbuy),
            headers: heaaders,
          );

          print(response.body);

          var bod = json.decode(response.body);
          String message = bod["message"];
          String codonly = bod["codonly"];
          var products = bod["products"];
          int total = bod["totalPrice"];


          if(message=="success"){
            sharedPreferences.setString('products',json.encode(products));
            sharedPreferences.setString('totalMrp',total.toString());

            if(codonly == "true"){
              Navigator.of(context).pop();

              Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderConfirmed()) );
            }else{

              String urle = bod["url"];
              var postData = bod["postData"];

              String appId,orderId,orderCurrency,orderNote,customerName,customerEmail,returnUrl,notifyUrl,secretKey;
              int orderAmount,customerPhone;
              appId = postData["appId"];
              orderId = postData["orderId"];
              orderAmount = postData["orderAmount"];
              orderCurrency = postData["orderCurrency"];
              orderNote = postData["orderNote"];
              customerName = postData["customerName"];
              customerEmail = postData["customerEmail"];
              customerPhone = postData["customerPhone"];
              returnUrl = postData["returnUrl"];
              notifyUrl = postData["notifyUrl"];
              secretKey = postData["secretKey"];


              dynamic ybody = {'appId':'$appId','orderId': '$orderId','orderAmount':'$orderAmount', 'orderCurrency':'$orderCurrency',
                'orderNote': '$orderNote','customerName': '$customerName','customerEmail': '$customerEmail','customerPhone':'$customerPhone',
                'returnUrl':'$returnUrl','notifyUrl': '$notifyUrl','secretKey':'$secretKey'};


              http.Response response = await http.post(urle,headers:heaaders,body:ybody);
              print("cashfree response");
              print(response.body);

              var bode = json.decode(response.body);
              String status = bode["status"];
              String paymentLink = bode["paymentLink"];
              print(status);

              if(status == "OK"){
                sharedPreferences.setString('paymentLink',paymentLink);
                Navigator.of(context).pop();

                Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentGateway()) );

              }
            }


          }else{
            Navigator.of(context).pop();

            showdia("Something went wrong, try again");

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
  void showdia(String message){
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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


}




/*
Stack(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Visibility(
              visible: codproducts == null?false:true,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                      Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                    ],
                  ),
                ),
            ),
            Visibility(
              visible: pgproducts == null?false:true,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
            ),

            new Padding(padding: const EdgeInsets.only(top: 25.0,right: 25.0,left:25.0),child:
            ButtonTheme(
              minWidth: 200.0,
              height: 60.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: (){
                  payment();
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: new Text("Continue to Payment",textScaleFactor: 1.2,),
              ),
            )
            ),

          ]
      )

      */