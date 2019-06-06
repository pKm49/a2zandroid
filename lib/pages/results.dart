/// ListTile

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/productresults.dart';
import 'package:a2zonlinshoppy/components/productresultsltoh.dart';
import 'package:a2zonlinshoppy/components/productresultshtol.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import  'package:shared_preferences/shared_preferences.dart';

class Results extends StatefulWidget {


  @override
  ResultsState createState() => ResultsState();
}

class ResultsState extends State<Results> {
  bool prodres=true, prodresltoh = false, prodreshtol=false;
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;

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
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('searchkey',key);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

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
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child:
                ButtonTheme(
                  minWidth: 200.0,
                  height: MediaQuery.of(context).size.height * .08,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {
                        prodres = false;
                        prodreshtol = false;
                        prodresltoh=true;
                      });
                    },
                    child: new Text("Price:Low to High"),
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: MediaQuery.of(context).size.height * .08,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {
                        prodres = false;
                        prodresltoh = false;
                        prodreshtol=true;
                      });
                    },
                    child: new Text("Price:High to Low"),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: prodres==true?true:false,
              child:ProductResults()
          ),
          Visibility(
              visible: prodresltoh==true?true:false,
              child:ProductResultsLtoH()
          ),
          Visibility(
              visible: prodreshtol==true?true:false,
              child:ProductResultsHtoL()
          )
        ],
      ),
    );
  }
}



/*
Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: (){},
                      child: new Text("Load More"),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: (){},
                      child: new Text("Load More"),
                    ),
                  ),
                ],
              ),
 */
