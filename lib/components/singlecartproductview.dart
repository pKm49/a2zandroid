import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/addresspage.dart';
import 'package:a2zonlinshoppy/pages/useraddresspage.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';

class SingleCartProductView extends StatefulWidget {
  @override
  _SingleCartProductViewState createState() => _SingleCartProductViewState();
}

class _SingleCartProductViewState extends State<SingleCartProductView> {

  BuildContext bcont;
  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int totalMrp=0,totalPrice=0,totalDisc=0,totalQty=0,len;

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


  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


  Future<String> getJsonData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/cart';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;


    check().then((intenet) async{
      if (intenet != null && intenet) {
        var response = await http.get(
            Uri.encodeFull(url),
            headers: heaaders
        );

        print("respoinse");
        print(response.body);

        var mobiles = json.decode(response.body);

        print("prods");
        print(mobiles["products"]);
        setState(() {
          data = mobiles["products"];
          print("specs");
          print(mobiles["totalMrp"]);
          len =data.length;
          totalMrp = mobiles["totalMrp"];
          totalDisc = mobiles["totalDisc"];
          totalPrice = mobiles["totalPrice"];
          totalQty = mobiles["totalQty"];
        });
        return "success";
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
                    Navigator.of(context).pop();
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
    bcont =context;
    return ListView(
      children: <Widget>[
        Visibility(
          visible: totalQty==0?false:true,
          child: Container(
            height: MediaQuery.of(context).size.height *1,
            child: Column(
              children: <Widget>[

                 Container(
                   decoration:  new BoxDecoration(
                       color: Colors.white,
                       border: new Border(bottom: BorderSide(color: Colors.grey,width: 2.0),)
                   ),

                  height: MediaQuery.of(context).size.height *.5,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: len,
                    itemBuilder: (BuildContext context, int index){
                      return Single_products(
                        title:data[index]['items']['title'],
                        picture:'https://www.a2zonlineshoppy.com/public2/products/'+data[index]['items']['_id']+'imageone.jpg',
                        price:data[index]['items']['a2zMoney'] == null? (data[index]['items']['oldPrice']-((data[index]['items']['oldPrice'] * data[index]['items']['a2zPrice'])/100).round()):data[index]['items']['a2zMoney'],
                        id:data[index]['items']['_id'],
                        size:data[index]['size'],
                        color:data[index]['color'],
                        point:data[index]['point'],
                        qty:data[index]['qty']
                      );
                    },
                  ),
                ),
                 Container(

                   alignment: Alignment.center,

                   height: MediaQuery.of(context).size.height *.25,
                   decoration:  new BoxDecoration(
                       color: Colors.grey.shade100,
                       border: new Border(bottom: BorderSide(color: Colors.grey,width: 2.0),)
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       new Padding(padding: const EdgeInsets.all(8.0),child:
                       Text("Cart Details ($totalQty items)",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.5)),
                       new Padding(padding: const EdgeInsets.all(8.0),child:
                       Row(
                         children: <Widget>[
                           Expanded(
                               flex: 2,
                               child:Text("Total MRP:",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.1,)),
                           Expanded(
                               flex: 1,
                               child:Text("₹$totalMrp",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.end,textScaleFactor: 1.1)
                           ),
                         ],
                       )),

                       new Padding(padding: const EdgeInsets.all(8.0),child:
                       Row(

                         children: <Widget>[
                           Expanded(
                               flex: 2,
                               child:Text("Total Discount:",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.1,)),
                           Expanded(
                               flex: 1,
                               child:Text("₹$totalDisc",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.end,textScaleFactor: 1.1)
                           ),
                         ],
                       )),

                       Container(
                         decoration:  new BoxDecoration(

                             border: new Border(top: BorderSide(color: Colors.grey.shade500,width: 1.0),)
                         ),
                         child:new Padding(padding: const EdgeInsets.all(8.0),child:
                         Row(

                           children: <Widget>[
                             Expanded(
                                 flex: 2,
                                 child:Text("Total Payable:",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.4,)),
                             Expanded(
                                 flex: 1,
                                 child:Text("₹$totalPrice",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.end,textScaleFactor: 1.4)
                             ),
                           ],
                         )),
                       ),
                     ],
                   ),
                 ),
                 new Padding(padding: const EdgeInsets.only(top: 20.0,left:10.0),child:
                 Text("(All price include tax)",textAlign: TextAlign.center,textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),)),

                 ButtonTheme(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  minWidth: MediaQuery.of(context).size.width *.8,
                  height: MediaQuery.of(context).size.height *.08,
                  child:
                  new Padding(padding: const EdgeInsets.all(5.0),child:
                  RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: (){

                        checkout();

                      },
                      child: Text('Checkout',textAlign: TextAlign.center,textScaleFactor: 1.5,)
                  )),
                )
              ],
            ),
          )
        ),
        Visibility(
          visible: totalQty==0?true:false,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height *1.0,
              child: Text('Your Cart is Empty',textAlign: TextAlign.center,textScaleFactor: 1.5,)
          ),
        )
      ],
    );
  }


  void checkout() async{
    String cook ;
    String tock ;
    String cod ;
    String products ;
    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/checkout';
    String message1 = "";
    String message2 = "";
    String message3 = "";
    sharedPreferences = await SharedPreferences.getInstance();
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');





    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;


      var response = await http.get(
          Uri.encodeFull(urlbuy),
          headers: heaaders,
      );

      print(response.body);

      var bod = json.decode(response.body);
      String message = bod["message"];

      print("checkout");
      print(bod);

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
      }else if((message=="success")){
        setState(() {
          cod = bod["cod"].toString();
          products = json.encode(bod["products"]);
        });

        sharedPreferences.setString('cod',cod);
        sharedPreferences.setString('products',products);

        if(name == null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressPage()) );
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAddressPage()) );
        }

      }


  }
}




class Single_products extends StatelessWidget {
  final title;
  final picture;
  final rating;
  final id;
  final size;
  final qty;
  final color;
  final point;
  final price;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.point,
    this.size,
    this.qty,
    this.color,
    this.price,

  });

  @override
  Widget build(BuildContext context) {

    int pr = price.round();
    String clr;
    if(color==""){
      clr="default";
    }else{
      clr=color;
    }
    return   Container(
      decoration:  new BoxDecoration(
          border: new Border(top: BorderSide(color: Colors.grey.shade300,width: 1.0),)
      ),
      height: 200.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child:
                InkWell(
                  onTap: ()async{
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('productId',id);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductView()) );
                  },
                  child:             Image.network('$picture',height: 100.0),

                ),
          ),
          Expanded(
            flex: 3,
            child:new Padding(padding: const EdgeInsets.all(5.0),child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$title',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.2,),
                Text('Price : ₹$pr',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Size :$size',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Color : $clr',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Quantity : $qty',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Point : $point',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                ButtonTheme(
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: (){
                      remove(id,context);
                      },
                    child: new Text("Remove",textScaleFactor: 1.2,),
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }

  void remove(id,context) async{
    print("idada");
    print(id);
    SharedPreferences sharedPreferences;
    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/removeone/$id';
    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    var response = await http.get(
        Uri.encodeFull(url),
        headers: heaaders
    );
    print(response.body);

    var mobiles = json.decode(response.body);
    print('message');
    print(mobiles["message"]);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Cart()) );

  }


}

