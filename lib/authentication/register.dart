import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Home.dart';
import 'package:a2zonlinshoppy/authentication/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool isLoggedin;
  bool loading;
  var client = http.Client();
  Map<String, String> heaaders = {};
  var csrf;
  var bod;
  String userdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }
  void isSignedIN() async{
    setState(() {
      loading =true;
    });

    heaaders['Accept'] = "application/JSON";
    sharedPreferences = await SharedPreferences.getInstance();

    String cook = sharedPreferences.getString('Cookie');
    String uname = sharedPreferences.getString('username');
    csrf = sharedPreferences.getString('csrf');

      print("csrf");
      print(csrf);

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;

      if(uname == null){
        isLoggedin = false;
      }else{
        setState(() {

          isLoggedin = false;
        });
      }

      if(isLoggedin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
      }else{
        setState(() {
          loading = false;
        });
      }



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
  Future handleSignIn() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[

              Visibility(
                  visible: loading ?? true,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  )
              ),
              Visibility(
                visible: loading ? false:true,
                child: Center(

                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child:
                    new Padding(padding: const EdgeInsets.only(right: 25.0,left:25.0),child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Text("Sign Up",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),),
                        new Padding(padding: const EdgeInsets.only(top:16.0),child:

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
                          controller: namecontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 13.0),child:

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
                          controller: usernamecontroller,
                          keyboardType: TextInputType.phone,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 13.0),child:
                        TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                                  color: Colors.blue
                              ),
                            ),

                            //fillColor: Colors.green
                          ),
                          controller: passwordcontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                        ),

                        new Padding(padding: const EdgeInsets.only(top: 25.0),child:
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ButtonTheme(
                                minWidth: 200.0,
                                height: 60.0,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  onPressed: (){
                                    validateForm();
                                  },
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  child: new Text("Sign Up",textScaleFactor: 1.2,),
                                ),
                              ),
                            )
                          ],
                        )
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 15.0),child:
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:
                              new Padding(padding: const EdgeInsets.only(right:5.0),child:
                              ButtonTheme(
                                minWidth: 200.0,
                                height: 60.0,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.red,
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()) );
                                  },
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  child: new Text("Sign In",textScaleFactor: 1.2,),
                                ),
                              )),
                            ),
                            Expanded(
                              child:new Padding(padding: const EdgeInsets.only(left:5.0),child:
                              ButtonTheme(
                                height: 60.0,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
                                  },
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                  child: new Text("skip",textScaleFactor: 1.2,),
                                ),
                              )),
                            ),
                          ],
                        )
                        )
                      ],
                    )),
                  ),
                ),
              )


            ]
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

        String message1 = "";
        String message2 = "";
        String message3 = "";
        String error = "";
        String message = "";
        String mobile = "";
        String name = "";
        var user;

        var username = usernamecontroller.text;
        var usersname = namecontroller.text;
        var password = passwordcontroller.text;

        if(username.isEmpty){
          message1="MobileNumber Can't be Empty";
        }else{
          Pattern pattern = r'^[0-9]{10}$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(username)){
            message1="MobileNumber is not valid";
          }else{
            message1="ok";
          }
        }

        if(password.isEmpty){
          message2="Password Can't be Empty";
        }else if (password.length < 4 ){
          message2="Password must be 6 charactors atleast";
        }else{
          message2="ok";
        }

        if(usersname.isEmpty){
          message3="Name Can't be Empty";
        }else if (usersname.length < 4 ){
          message3="Password must be 4 charactors atleast";
        }else{
          message3="ok";
        }

        dynamic mybody = {"name": "$usersname",'username': '$username','password': '$password', '_csrf': '$csrf','cardholder':'false'};

        if(message1 == "ok" && message2 =="ok" && message3 =="ok"){

          dynamic respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/signup",headers:heaaders,body:mybody);

          print(respons.body);
          print(respons.headers['set-cookie']);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];

          error = bod["error"];
          message = bod["message"];
          if(message == "success"){
            user = bod["user"];
            userdata = json.encode(user);
            print("userdata");
            print(userdata);
            name = user["name"];
            mobile = user["username"];
            print(error);
            print(respons);
            print(name);
            print(mobile);

            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString("name", name);
            sharedPreferences.setString("mobile", mobile);
            sharedPreferences.setString("userdata", userdata);
            sharedPreferences.setString("tocken", tock);
            sharedPreferences.setString("username", username);
            sharedPreferences.setString("password", password);
            Navigator.of(context).pop();

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(error),
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



      }else {
        Navigator.of(context).pop();

        showDialog<void>(
          context: context,
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










