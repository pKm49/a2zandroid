import 'dart:io';

import 'package:flutter/material.dart';
import 'PreHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Visibility(child: new CircularProgressIndicator(),);
}

void main() async{


  ErrorWidget.builder = (errorDetails) {
    return Container( child:
        Center(
          child: CircularProgressIndicator(),
        )
    );
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async{



    runApp(
        MaterialApp(
          title: "A2ZOnlineShoppy",
            theme: ThemeData(
                primaryColor: Colors.red,
                secondaryHeaderColor: Colors.red
            ),
            debugShowCheckedModeBanner: false,
            home:  PreHomePage()
        ));
  });

}
