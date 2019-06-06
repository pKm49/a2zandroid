import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/paymentgateway.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/searchresults.dart';

class CardAddressPage extends StatefulWidget {
  @override
  _CardAddressPageState createState() => _CardAddressPageState();
}

class _CardAddressPageState extends State<CardAddressPage> {
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock,cardname,agevalue;
  int baseprice;
  Map<String, String> heaaders = {};
  bool codenable,cod,sameasshipping = false,diamondtwo =false,diamondthree=false;
  var card;


  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController fatherhusbandcontroller = TextEditingController();
  TextEditingController proffessioncontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  DateTime dateobcontroller = DateTime.now();
  int agecontroller;
  TextEditingController nomineecontroller = TextEditingController();
  TextEditingController relationshipcontroller = TextEditingController();
  TextEditingController executiveidcontroller = TextEditingController();

  TextEditingController diamondnamecontroller1 = TextEditingController();
  TextEditingController diamondrelationshipcontroller1 = TextEditingController();
  TextEditingController diamondagecontroller1= TextEditingController();
  TextEditingController diamondnomineecontroller1 = TextEditingController();

  TextEditingController diamondnamecontroller2 = TextEditingController();
  TextEditingController diamondrelationshipcontroller2 = TextEditingController();
  TextEditingController diamondagecontroller2 = TextEditingController();
  TextEditingController diamondnomineecontroller2 = TextEditingController();

  TextEditingController diamondnamecontroller3 = TextEditingController();
  TextEditingController diamondrelationshipcontroller3 = TextEditingController();
  TextEditingController diamondagecontroller3 = TextEditingController();
  TextEditingController diamondnomineecontroller3 = TextEditingController();




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
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');
    String cards = sharedPreferences.getString('card');




    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    setState(() {

      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

      card = json.decode(cards);
      cardname = card["name"];
      baseprice = card["baseprice"];

      print("card");
      print(card);
      print(cardname);
      print(baseprice);

    });

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
                visible: true,
                child: Column(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("$cardname Card (₹$baseprice)",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),
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
                    new Padding(padding: const EdgeInsets.only(top:10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Father / Husband',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: fatherhusbandcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Proffession',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: proffessioncontroller,
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

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width *1.0 ,
                      height: 60.0,
                      child: RaisedButton(
                        textColor: Colors.grey.shade600,
                        color: Colors.white,
                        onPressed: (){
                          _selectDate(context);
                        },
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),side: BorderSide(color: Colors.grey.shade600,width: 1.0)),
                        child: new Text("Date of Birth",textScaleFactor: 1.2,),
                      ),
                    )
                    ),
                    Visibility(
                      visible:agecontroller==null?false:true ,
                      child: new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                      Text("Age: $agecontroller",textAlign: TextAlign.center,textScaleFactor: 1.5,style: TextStyle(fontWeight: FontWeight.bold),)),


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
                        hintText: 'Nominee',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        //fillColor: Colors.green
                      ),
                      controller: nomineecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),
                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Relationship',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: relationshipcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                    TextFormField(
                      decoration: new InputDecoration(
                        hintText: 'Executive ID',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                              color: Colors.blue
                          ),
                        ),

                        //fillColor: Colors.green
                      ),
                      controller: executiveidcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                    ),

                    Visibility(
                      visible: cardname == "Diamond"?true:false,
                      child: Column(
                        children: <Widget>[

                          new Padding(padding: const EdgeInsets.only(top: 10.0),child:
                          Text("Details of Family Members",textAlign: TextAlign.center,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade600),)),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Name',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnamecontroller1,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Age',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondagecontroller1,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Nominee',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnomineecontroller1,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Relationship',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondrelationshipcontroller1,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.all(20.0),child:
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width *1.0 ,
                            height: 60.0,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.green,
                              onPressed: (){
                                setState(() {
                                  diamondtwo = true;
                                });
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              child: new Text("Add One",textScaleFactor: 1.2,),
                            ),
                          )
                          ),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: diamondtwo == true?true:false,
                      child: Column(
                        children: <Widget>[

                          new Padding(padding: const EdgeInsets.only(top: 10.0),child:
                          Text("Details of Family Members",textAlign: TextAlign.center,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade600),)),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Name',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnamecontroller2,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Age',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondagecontroller2,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Nominee',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnomineecontroller2,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Relationship',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondrelationshipcontroller2,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.all(20.0),child:
                            Row(
                            children: <Widget>[
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
                                  color: Colors.green,
                                  onPressed: (){
                                    setState(() {

                                      diamondthree =true;
                                    });
                                  },
                                  child: Text('Add One',textAlign: TextAlign.center,textScaleFactor: 1.2,)
                              )),
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
                                  color: Colors.red,
                                  onPressed: (){
                                    setState(() {
                                      diamondtwo =false;
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Expanded( child: Text('Delete',textAlign: TextAlign.center,textScaleFactor: 1.2,),)
                                    ],
                                  )
                              ),),
                            ),),
                        ],
                      ),
                          ),


                        ],
                      ),
                    ),

                    Visibility(
                      visible: diamondthree == true?true:false,
                      child: Column(
                        children: <Widget>[

                          new Padding(padding: const EdgeInsets.only(top: 10.0),child:
                          Text("Details of Family Members",textAlign: TextAlign.center,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade600),)),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Name',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnamecontroller3,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Age',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondagecontroller3,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Nominee',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondnomineecontroller3,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.only(top: 10.0,right: 25.0,left:25.0),child:
                          TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Relationship',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.blue
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                            controller: diamondrelationshipcontroller3,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )
                          ),

                          new Padding(padding: const EdgeInsets.all(20.0),child:
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width *1.0 ,
                            height: 60.0,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red,
                              onPressed: (){
                                setState(() {
                                  diamondthree = false;
                                });
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              child: new Text("Delete",textScaleFactor: 1.2,),
                            ),
                          )
                          ),


                        ],
                      ),
                    ),

                    new Padding(padding: const EdgeInsets.only(top:10.0,left:20.0),child:
                    Row(
                    children: <Widget>[
                        Checkbox(
                        onChanged: (bool value) => onsameasshippingchanged(value),
                        value:sameasshipping,
                        ),
                        new InkWell(
                        onTap: (){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Terms and Conditions'),
                                content: Text("- Minimum 24 hours admit in hospital \n-Original hospital documents, Bills & Discharge Summary \n-Road accidents FIR attested copy \n-Death certificate \n-Postmortem Report \n-Privilege Card Copy \n-Identity Card Copy \n-Bank Details Copy "),
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

                        },
                        child:
                        new Padding(padding: const EdgeInsets.only(left: 5.0),child:
                        Text("I agree to terms and conditions",textAlign: TextAlign.center,textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade600),)),

                        ),
                    ],
                    )
                    ),

              new Padding(padding: const EdgeInsets.all(20.0),child:
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width *1.0 ,
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
    ]
    ))
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateobcontroller,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateobcontroller)
      dateobcontroller = picked;

    final birthday = dateobcontroller;
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    agecontroller = (difference/365).round();
    print("age");
    print(dateobcontroller);
    print(date2);
    print(agecontroller);

    setState(() {
      dateobcontroller = picked;
      agecontroller = (difference/365).round();
    });

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
          dynamic mybody;

          List diamondname=[],diamondage=[],diamondnominee=[],diamondrelationship=[];

          var name= fullnamecontroller.text;
          var fatherhusband= fatherhusbandcontroller.text;
          var proffession = proffessioncontroller.text;
          var mobile=mobilecontroller.text;
          var email=emailcontroller.text;
          var house=housecontroller.text;
          var post=postofficecontroller.text;
          var district=districtcontroller.text;
          var state=statecontroller.text;
          var pincode=pincontroller.text;
          DateTime dateob=dateobcontroller;
          var age=agecontroller;
          var nominee=nomineecontroller.text;
          var relationship=relationshipcontroller.text;
          var executiveid=executiveidcontroller.text;

          var diamondname1=diamondnamecontroller1.text;
          var diamondrelationship1=diamondrelationshipcontroller1.text;
          var diamondage1=diamondagecontroller1.text;
          var diamondnominee1=diamondnomineecontroller1.text;

          var diamondname2=diamondnamecontroller2.text;
          var diamondrelationship2=diamondrelationshipcontroller2.text;
          var diamondage2=diamondagecontroller2.text;
          var diamondnominee2=diamondnomineecontroller2.text;

          var diamondname3=diamondnamecontroller3.text;
          var diamondrelationship3=diamondrelationshipcontroller3.text;
          var diamondage3=diamondagecontroller3.text;
          var diamondnominee3=diamondnomineecontroller3.text;


          if(name.isEmpty){
            isempty =true;
            showdia("Name can't be empty");
          }if(fatherhusband.isEmpty){
            isempty =true;
            showdia("Father / Husband can't be empty");
          }if(proffession.isEmpty){
            isempty =true;
            showdia("Proffession can't be empty");
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
          }else if(post.isEmpty){
            isempty =true;
            showdia("Postoffice can't be empty");
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
          }else if(dateob == null){
            isempty =true;
            showdia("Date of Birth can't be empty");
          }else if(age== null){
            isempty =true;
            showdia("Age can't be empty");
          }else if(nominee.isEmpty){
            isempty =true;
            showdia("Nominee can't be empty");
          }else if(sameasshipping==false){
            isempty =true;
            showdia('Please agree to the terms and conditions');
          }

          if( cardname == "Diamond"){
            if(diamondname1.isEmpty){
              isempty =true;
              showdia("Name can't be empty");
            }else if(diamondnominee1.isEmpty){
              isempty =true;
              showdia("Nominee can't be empty");
            }else if(diamondage1.isEmpty){
              isempty =true;
              showdia("Age can't be empty");
            }else if(diamondrelationship1.isEmpty){
              isempty =true;
              showdia("Relationship can't be empty");
            }
          }

          if(diamondtwo == true){
            if(diamondname2.isEmpty){
              isempty =true;
              showdia("Name can't be empty");
            }else if(diamondnominee2.isEmpty){
              isempty =true;
              showdia("Nominee can't be empty");
            }else if(diamondage2.isEmpty){
              isempty =true;
              showdia("Age can't be empty");
            }else if(diamondrelationship2.isEmpty){
              isempty =true;
              showdia("Relationship can't be empty");
            }
          }

          if(diamondthree == true){
            if(diamondname3.isEmpty){
              isempty =true;
              showdia("Name can't be empty");
            }else if(diamondnominee3.isEmpty){
              isempty =true;
              showdia("Nominee can't be empty");
            }else if(diamondage3.isEmpty){
              isempty =true;
              showdia("Age can't be empty");
            }else if(diamondrelationship3.isEmpty){
              isempty =true;
              showdia("Relationship can't be empty");
            }
          }



          if( cardname == "Diamond"){

            if(isempty ==false) {
              diamondname.add((diamondname1));
              diamondage.add((diamondage1));
              diamondnominee.add((diamondnominee1));
              diamondrelationship.add((diamondrelationship1));

              if(diamondtwo){
                diamondname.add((diamondname2));
                diamondage.add((diamondage2));
                diamondnominee.add((diamondnominee2));
                diamondrelationship.add((diamondrelationship2));
              }

              if(diamondthree){
                diamondname.add((diamondname3));
                diamondage.add((diamondage3));
                diamondnominee.add((diamondnominee3));
                diamondrelationship.add((diamondrelationship3));
              }

              mybody = {'executiveid':'$executiveid','name': '$name','fatherhusband':'$fatherhusband', 'proffession':'$proffession', 'mobile': '$mobile','email': '$email','house': '$house','dob':'$dateob','age':'$age','postoffice': '$post','nominee':'$nominee','relationship':'$relationship','district': '$district', 'state': '$state', 'pincode': '$pincode','diamondname':'$diamondname','diamondage':'$diamondage','diamondnominee':'$diamondnominee','diamondrelationship':'$diamondrelationship', '_csrf': '$csrf','cardname':'$cardname','baseprice':'$baseprice'};

            }else{
              showdia("Fields Can't be Empty");
            }
          }else{
            if(isempty == false) {
              mybody = {'executiveid':'$executiveid','name': '$name','fatherhusband':'$fatherhusband', 'proffession':'$proffession', 'mobile': '$mobile','email': '$email','house': '$house','dob':'$dateob','age':'$age','postoffice': '$post','nominee':'$nominee','relationship':'$relationship','district': '$district', 'state': '$state', 'pincode': '$pincode', '_csrf': '$csrf','cardname':'$cardname','baseprice':'$baseprice'};
            }else{
              showdia("Fields Can't be Empty");
            }
          }

          print(heaaders);

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await http.post("https://www.a2zonlineshoppy.com/api/checkoutcard/1",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          var bod = json.decode(respons.body);
          String message = bod["message"];


          print("message");
          print(message);

          if(message=="success"){
            String urle = bod["url"];
            var postData = bod["postData"];

            String appId,orderId,customerPhone,orderAmount,orderCurrency,orderNote,customerName,customerEmail,returnUrl,notifyUrl,secretKey;
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
    Navigator.of(context).pop();

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


