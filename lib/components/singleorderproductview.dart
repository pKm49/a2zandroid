import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/orders.dart';

class SingleOrderProductView extends StatefulWidget {
  @override
  _SingleOrderProductViewState createState() => _SingleOrderProductViewState();
}

class _SingleOrderProductViewState extends State<SingleOrderProductView> {

  BuildContext bcont;

  List<SingleOrder> orders =[];
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int len,le;
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
    final String url = 'https://www.a2zonlineshoppy.com/api/orders';

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

        print(response.body);

        var mobiles = json.decode(response.body);
        int k =0;


        var dat = mobiles["orders"];
        List<SingleOrder> ords=[];
        if(dat == null){
          le=0;
        }else{

          for(int i=0;i<dat.length;i++){
            for(int j=0;j<dat[i]["products"].length;j++){
              print(dat[i]["products"].length);
              print("order $i and product $j");
              print("orderid");
              print(dat[i]["_id"]);
              ords.add(new SingleOrder(
                  products: dat[i]["products"][j],
                  oddate: dat[i]["created_at"],
                  odid: dat[i]["_id"]
              ));
              k++;
            }
          }

        }
        setState(() {
          orders = ords;
          len =k;

          print("length is ");
          print(len);
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
          visible: len==null||len==0?false:true,
          child: Container(
            height: MediaQuery.of(context).size.height *1,
            child: ListView(
              children: <Widget>[
                 Container(
                   decoration:  new BoxDecoration(
                       color: Colors.white,
                       border: new Border(bottom: BorderSide(color: Colors.grey,width: 2.0),)
                   ),
                  height: MediaQuery.of(context).size.height *.9,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: len,
                    itemBuilder: (BuildContext context, int index){
                      return Single_products(
                        title:orders[index].products['title'],
                        picture:'https://www.a2zonlineshoppy.com/public2/products/'+orders[index].products['id']+'imageone.jpg' ,
                        price:orders[index].products['price'] ,
                        id:orders[index].products['id'],
                          pid:orders[index].products['_id'],
                        odid:orders[index].odid,
                        size:orders[index].products['size'],
                        color:orders[index].products['color'],
                        point:orders[index].products['status'],
                        qty:orders[index].products['quantity'],
                        date:orders[index].oddate
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ),
        Visibility(
          visible: len==null||len==0?true:false,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height *.90,
              child: Text('Your haven\'t placed any orders yet',textAlign: TextAlign.center,textScaleFactor: 1.5,)
          ),
        )
      ],
    );
  }
}







class SingleOrder {
  final oddate;
  final products;
  final odid;
  SingleOrder({
    this.oddate,
    this.products,
    this.odid,
  });
}




class Single_products extends StatelessWidget {

  final title;
  final picture;
  final rating;
  final id;
  final pid;
  final odid;
  final size;
  final qty;
  final color;
  final point;
  final price;
  final date;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.pid,
    this.odid,
    this.point,
    this.size,
    this.qty,
    this.color,
    this.price,
    this.date,

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

    var dat = DateTime.parse(date);
    var format = new DateFormat("dd-MM-yyyy");

    String formatdate = format.format(dat);

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
                Text('Ordered On : $formatdate',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Status : $point',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Visibility(
                  visible: point=="cancelled"?false:true,
                  child: ButtonTheme(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      onPressed: (){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirmation '),
                              content: Text("Are you sure you want to cancel this order? This cannot be undone."),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('yes'),
                                  onPressed: () {
                                    cancel(odid,pid,context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('no'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        },
                      child: new Text("cancel",textScaleFactor: 1.2,),
                    ),
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }

  void cancel(oid,pid,context) async{
    print("idada");
    print(pid);
    print(oid);
    SharedPreferences sharedPreferences;
    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/cancelorder/$oid/$pid';
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
    String message = mobiles["message"];
    print('message');
    print(mobiles["message"]);

    if(message=="success"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Orders()) );

    }else{
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error '),
            content: Text("Something went wrong, please try again"),
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


}

