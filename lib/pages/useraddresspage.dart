import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/bill.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';


class UserAddressPage extends StatefulWidget {
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}


class _UserAddressPageState extends State<UserAddressPage> {

  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock,userdata,deladress,email;
  Map<String, String> heaaders = {};
  bool codenable=false,cod,sameasshipping = true,showstoredaddress=false;
  var products;


  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController fullnamecontrollerbill = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController deladdresscontroller = TextEditingController();
  TextEditingController mobilecontrollerbill = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController emailcontrollerbill = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController housecontrollerbill = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController postofficecontrollerbill = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController nearesttowncontrollerbill = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController districtcontrollerbill = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController statecontrollerbill = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController pincontrollerbill = TextEditingController();

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

    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
    String message1 = "";
    String message2 = "";
    String message3 = "";
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');
    userdata = sharedPreferences.getString('userdata');
    String code = sharedPreferences.getString('cod');
    String pr = sharedPreferences.getString('products');
    var  prods = json.decode(pr);

    print("cookiesuseraddress");
    print(cook);


    var user = json.decode(userdata);
    print("userdata");
    print(userdata);
    String userhouse = (user["deladdress"][0]["house"]);
    print(userhouse);
    if(userhouse == "Enter "){
      showstoredaddress = false;
    }else{
      showstoredaddress = true;
      email = user["email"];
      deladress = user["deladdress"][0]["name"]+"\n"+user["deladdress"][0]["house"]+"\n"+user["deladdress"][0]["postoffice"]+"\n"+user["deladdress"][0]["district"]+"\n"+user["deladdress"][0]["state"]+"\n"+user["deladdress"][0]["pincode"]+"\n"+user["deladdress"][0]["mobile"]+"\n"+user["deladdress"][0]["email"];
    }
    if(code == null){
      message1 = "cod can't be empty";
    }else{
      message1 = "ok";
    }

    if(prods == null){
      message2 = "prods can't be empty";
    }else{
      message2 = "ok";
    }

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    if(message1 == "ok" && message2 =="ok"){
        setState(() {
          if(code == "true"){
            cod = true;
          }else  if(code == "false"){
            cod = false;
          }

          products = prods;

          print("hello products");
          print(products.length);
        });

    }else{
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty fields'),
            content: Text(message1+"\n"+message2+"\n"+message3),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  void oncodchanged(bool tile) async {

    setState(() {
      codenable = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codenabled',tile.toString());
    print('codenabled');
    print(sharedPreferences.getString('codenabled'));
  }

  void onsameasshippingchanged(bool tile) async {

    setState(() {
      sameasshipping = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('sameasshipping',tile.toString());
    print('sameasshipping');
    print(sharedPreferences.getString('sameasshipping'));
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
      body:  Container(
        height:MediaQuery.of(context).size.height *1.0 ,
        child: ListView(
            children: <Widget>[
              Visibility(
                  visible: cod == true? true:false,
                    child: new Padding(padding: const EdgeInsets.all( 8.0),child:
                    Card(
                      child: Column(
                        children: <Widget>[
                          new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                          Text("Following products are COD enabled!",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),)),
                          new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                          Container(
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border (bottom: BorderSide(color:Colors.grey,width: 1.0))
                            ),
                            height: products.length*50.0,
                            child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index){
                                return
                                  new Padding(padding: const EdgeInsets.only(left:20.0),child:

                                  Text(" -  "+products[index]["title"],textAlign: TextAlign.start,textScaleFactor: 1.2,style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold),));
                              },
                            ),
                          )),
                          new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                          Text("Enable cash on delivery for these items?",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),)),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (bool str) => oncodchanged(str),
                                      value:true,
                                      groupValue: codenable,
                                    ),
                                    new Text("Yes"),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (bool str) => oncodchanged(str),
                                      value:false,
                                      groupValue: codenable,
                                    ),
                                    new Text("No"),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Visibility(
                visible: showstoredaddress?true:false,
                child: Column(
                  children: <Widget>[

                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("$name",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("$mobile",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("$email",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("$deladress",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (bool str) => onsameasshippingchanged(str),
                              value:true,
                              groupValue: sameasshipping,
                            ),
                            new Text("Same as shipping address"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (bool str) => onsameasshippingchanged(str),
                              value:false,
                              groupValue: sameasshipping,
                            ),
                            new Text("Choose a Different Billing Address"),
                          ],
                        ),
                      ],
                    )),


                  ],
                ),
              ),
              Visibility(
                visible: showstoredaddress?false:true,
                child: Column(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top:10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Full Name',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: fullnamecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Mobile',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: mobilecontroller,
                      keyboardType: TextInputType.phone,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: emailcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'House',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: housecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Post Office',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: postofficecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Landmark',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: nearesttowncontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'District',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: districtcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'State',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: statecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Pin',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: pincontroller,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (bool str) => onsameasshippingchanged(str),
                              value:true,
                              groupValue: sameasshipping,
                            ),
                            new Text("Same as shipping address"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              onChanged: (bool str) => onsameasshippingchanged(str),
                              value:false,
                              groupValue: sameasshipping,
                            ),
                            new Text("Choose a Different Billing Address"),
                          ],
                        ),
                      ],
                    )),


                  ],
                ),
              ),
              Visibility(
                visible: sameasshipping? false:true,
                child: Column(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Full Name',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: fullnamecontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Mobile',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: mobilecontrollerbill,
                      keyboardType: TextInputType.phone,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: emailcontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'House',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: housecontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Post Office',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: postofficecontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Landmark',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: nearesttowncontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'District',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: districtcontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'State',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: statecontrollerbill,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Pin',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: pincontrollerbill,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                  ],
                ),
              ),
              new Padding(padding: const EdgeInsets.all(20.0),child:
              ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: (){
                    validateForm();
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text("Check Out",textScaleFactor: 1.2,),
                ),
              )
              ),

            ]
        ),
      )

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




  void validateForm() async{

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

          String codproducts,pgproducts;
          bool isempty=false;

          var customername = fullnamecontroller.text;
          var billcustomername=fullnamecontrollerbill.text;
          var mobile=mobilecontroller.text;
          var billmobile=mobilecontrollerbill.text;
          var email=emailcontroller.text;
          var billemail=emailcontrollerbill.text;
          var deladdress=deladdresscontroller.text;
          var house=housecontroller.text;
          var billhouse=housecontrollerbill.text;
          var postoffice=postofficecontroller.text;
          var billpostoffice=postofficecontrollerbill.text;
          var city = nearesttowncontroller.text;
          var billcity=nearesttowncontrollerbill.text;
          var district=districtcontroller.text;
          var billdistrict =districtcontrollerbill.text;
          var state=statecontroller.text;
          var billstate=statecontrollerbill.text;
          var pincode= pincontroller.text;
          var billpincode = pincontrollerbill.text;


          if(showstoredaddress){
            if(mobile.isEmpty){
              isempty =true;
              showdia("Mobile can't be empty");
            }else if(!(mobile.isEmpty)){
              Pattern pattern = r'^[0-9]{10}$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(mobile)){
                isempty =true;
                showdia("MobileNumber is not valid");
              }
            }else if(email.isEmpty){
              isempty =true;
              showdia("Email can't be empty");
            }else if(!(email.isEmpty)){
              Pattern pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(email)){
                isempty =true;
                showdia("Email is not valid");
              }
            }else if(deladdress.isEmpty){
              isempty =true;
              showdia("Shipping Address can't be empty");
            }
          }else{

            if(customername.isEmpty){
              isempty =true;
              showdia("Name can't be empty");
            }else if(mobile.isEmpty){
              isempty =true;
              showdia("Mobile can't be empty");
            }else if(!(mobile.isEmpty)){
              Pattern pattern = r'^[0-9]{10}$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(mobile)){
                isempty =true;
                showdia("MobileNumber is not valid");
              }
            }else if(email.isEmpty){
              isempty =true;
              showdia("Email can't be empty");
            }else if(!(email.isEmpty)){
              Pattern pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(email)){
                isempty =true;
                showdia("Email is not valid");
              }
            }else if(house.isEmpty){
              isempty =true;
              showdia("House can't be empty");
            }else if(postoffice.isEmpty){
              isempty =true;
              showdia("Postoffice can't be empty");
            }else if(city.isEmpty){
              isempty =true;
              showdia("Landmark can't be empty");
            }else if(district.isEmpty){
              isempty =true;
              showdia("District can't be empty");
            }else if(state.isEmpty){
              isempty =true;
              showdia("State can't be empty");
            }else if(pincode.isEmpty){
              isempty =true;
              showdia("Pincode can't be empty");
            }



          }


          if(customername.isEmpty){
            isempty =true;
            showdia("Name can't be empty");
          }else if(mobile.isEmpty){
            isempty =true;
            showdia("Mobile can't be empty");
          }else if(!(mobile.isEmpty)){
            Pattern pattern = r'^[0-9]{10}$';
            RegExp regex = new RegExp(pattern);
            if(!regex.hasMatch(mobile)){
              isempty =true;
              showdia("MobileNumber is not valid");
            }
          }else if(email.isEmpty){
            isempty =true;
            showdia("Email can't be empty");
          }else if(!(email.isEmpty)){
            Pattern pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
            RegExp regex = new RegExp(pattern);
            if(!regex.hasMatch(email)){
              isempty =true;
              showdia("Email is not valid");
            }
          }else if(house.isEmpty){
            isempty =true;
            showdia("House can't be empty");
          }else if(postoffice.isEmpty){
            isempty =true;
            showdia("Postoffice can't be empty");
          }else if(city.isEmpty){
            isempty =true;
            showdia("Landmark can't be empty");
          }else if(district.isEmpty){
            isempty =true;
            showdia("District can't be empty");
          }else if(state.isEmpty){
            isempty =true;
            showdia("State can't be empty");
          }else if(pincode.isEmpty){
            isempty =true;
            showdia("Pincode can't be empty");
          }else if(!(pincode.isEmpty)){
            Pattern pattern = r'^[0-9]{6}$';
            RegExp regex = new RegExp(pattern);
            if(!regex.hasMatch(mobile)){
              isempty =true;
              showdia("Pincode is not valid");
            }
          }


          if(!sameasshipping){
            if(billcustomername.isEmpty){
              isempty =true;
              showdia("Name can't be empty");
            }else if(billmobile.isEmpty){
              isempty =true;
              showdia("Mobile can't be empty");
            }else if(!(billmobile.isEmpty)){
              Pattern pattern = r'^[0-9]{10}$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(billmobile)){
                isempty =true;
                showdia("MobileNumber is not valid");
              }
            }else if(billemail.isEmpty){
              isempty =true;
              showdia("Email can't be empty");
            }else if(!(billemail.isEmpty)){
              Pattern pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(billemail)){
                isempty =true;
                showdia("Email is not valid");
              }
            }else if(billhouse.isEmpty){
              isempty =true;
              showdia("House can't be empty");
            }else if(billpostoffice.isEmpty){
              isempty =true;
              showdia("Postoffice can't be empty");
            }else if(billcity.isEmpty){
              isempty =true;
              showdia("Landmark can't be empty");
            }else if(billdistrict.isEmpty){
              isempty =true;
              showdia("District can't be empty");
            }else if(billstate.isEmpty){
              isempty =true;
              showdia("State can't be empty");
            }else if(billpincode.isEmpty){
              isempty =true;
              showdia("Pincode can't be empty");
            }else if(!(billpincode.isEmpty)){
              Pattern pattern = r'^[0-9]{6}$';
              RegExp regex = new RegExp(pattern);
              if(!regex.hasMatch(mobile)){
                isempty =true;
                showdia("Pincode is not valid");
              }
            }
          }

          http.Response respons;

          print(heaaders);

          String sameas;
          String codsend;
          if(sameasshipping == true){
            sameas = "true";
          }else{
            sameas = "false";
          }

          if(codenable == true){
            codsend = "true";
          }else{
            codsend = "false";
          }

          if(isempty == false){

            if(showstoredaddress){

              dynamic mybody = {'sameasshipping':'$sameas','codenable':'$codsend','customername': '$name','billcustomername': '$billcustomername','mobile': '$mobile','billmobile': '$billmobile','email': '$email','billemail': '$billemail','address': '$deladdress','billhouse': '$billhouse','billpostoffice': '$billpostoffice','billcity': '$billcity','billdistrict': '$billdistrict','billstate': '$billstate', 'billpincode': '$billpincode', '_csrf': '$csrf'};

              sharedPreferences = await SharedPreferences.getInstance();
              respons = await http.post("https://www.a2zonlineshoppy.com/api/checkoutuser/3",headers:heaaders,body:mybody);

            }else{
              dynamic mybody = {'sameasshipping':'$sameas','codenable':'$codsend','customername': '$customername','billcustomername': '$billcustomername','mobile': '$mobile','billmobile': '$billmobile','email': '$email','billemail': '$billemail','house': '$house','billhouse': '$billhouse','postoffice': '$postoffice','billpostoffice': '$billpostoffice','city': '$city','billcity': '$billcity','district': '$district','billdistrict': '$billdistrict', 'state': '$state', 'billstate': '$billstate', 'pincode': '$pincode', 'billpincode': '$billpincode', '_csrf': '$csrf'};

              sharedPreferences = await SharedPreferences.getInstance();
              respons = await http.post("https://www.a2zonlineshoppy.com/api/checkoutuser/2",headers:heaaders,body:mybody);

            }


            print("ressssssss");
            print(respons.body);

            var bod = json.decode(respons.body);
            String message = bod["message"];
            print("message");
            print(bod);
            if(message=="success"){
              print("success");
              String codenable = bod["cod"];
              if(codenable == "true"){
                var codprods = bod["codproducts"];
                codproducts = json.encode(codprods);
                sharedPreferences.setString("codproducts", codproducts);

              }else{
                print("codenable");
                print(codenable);
              }

              print("codproducts");
              print(codproducts);
              var pgprods = bod["pgproducts"];
              print("pgprods");
              print(pgprods);

              pgproducts = json.encode(pgprods);


              sharedPreferences = await SharedPreferences.getInstance();

              sharedPreferences.setString("codenable", codenable);
              sharedPreferences.setString("pgproducts", pgproducts);
              sharedPreferences.remove('products');
              sharedPreferences.remove('cod');

              Navigator.of(context).pop();

              Navigator.push(context, MaterialPageRoute(builder: (context)=> BillPage()) );

            }


          }else{
            Navigator.of(context).pop();

            showdia("Try again with valid input");

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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}


