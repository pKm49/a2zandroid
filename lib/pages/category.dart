/// ListTile

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/categoryresults.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  SharedPreferences sharedPreferences;
  final TextEditingController _filter = new TextEditingController();

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
        body: new Padding(padding: const EdgeInsets.all(0.0),
              child:Container
                (
                  height: 850.0,
                  child:CategoryResults()

              )
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
