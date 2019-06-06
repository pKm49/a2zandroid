import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/aboutandpolicy/about.dart';
import 'package:a2zonlinshoppy/pages/results.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/orders.dart';
import 'package:a2zonlinshoppy/pages/account.dart';
import 'package:a2zonlinshoppy/Home.dart';


class AtozDrawer extends StatefulWidget {

  @override
  _AtozDrawerState createState() => _AtozDrawerState();
}

class _AtozDrawerState extends State<AtozDrawer> {

  SharedPreferences sharedPreferences;
  String name;
  String mobile;

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
    });

  }
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        //Header
        new UserAccountsDrawerHeader(
          accountName: name == null ? Text("Guest") : Text("$name"),
          accountEmail: mobile == null ? Text("Login") : Text("$mobile"),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person,color: Colors.blue,size: 40.0),
            ),
          ),
          decoration: new BoxDecoration(
            color: Colors.blue,
          ),
        ),
        //Body
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()) );
          },
          child: ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home, color: Colors.grey),
          ),
        ),
        ExpansionTile(
          title: Text("Men"),
          leading: Icon(MdiIcons.humanMale, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Men');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenClothing');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Clothing'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenFootWear');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('FootWear'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenWatches');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Watches'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenAccessories');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Accessories'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenPersonal Care');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Personal Care'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','MenOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Women'),
          leading: Icon(MdiIcons.humanFemale, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Women');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenClothing');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Clothing'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenFootwear');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('FootWear'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenWatches');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Watches'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenAccessories');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Accessories'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenPersonal Care');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Personal Care'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Jewellery');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Jewellery'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','WomenOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Baby and Kids'),
          leading: Icon(Icons.child_care, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Babies and Kids');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Babies and KidsClothing');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Clothing'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Babies and KidsFootwear');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('FootWear'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Baby Care');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Baby Care'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Toys');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Toys'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Babies and KidsOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Electronics'),
          leading: Icon(Icons.phone_android, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Electronics');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Mobiles');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Mobiles'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Tablets');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Tablets'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Mobile Accessories');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Mobile Accessories'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Laptops');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Laptops'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Desktop PCs');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Desktop PCs'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Computer Accessories');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('ComputerAccessories'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','ElectronicsOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Appliances'),
          leading: Icon(Icons.tv, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Appliances');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','TV');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('TV'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Washing Machines');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Washing Machines'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Air Conditioners');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Air Conditioners'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Refrigerators');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Refrigerators'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','AppliancesOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Home and Furniture'),
          leading: Icon(Icons.weekend, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Home and Furniture');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Kitchen');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Kitchen'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Dining');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Dining'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Furniture');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Furniture'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Home Decor');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Home Decor'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Lightning');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Lightning'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Home and FurnitureOthers');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        ExpansionTile(
          title: Text('Others'),
          leading: Icon(Icons.all_out, color: Colors.grey),
          children: <Widget>[
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','category');
                sharedPreferences.setString('key','Others');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('All'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Books');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Books'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','School Supplies');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('School Supplies'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Sports');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Sports'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Gaming');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Games'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Automobile');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Automobiles'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            ),
            InkWell(
              onTap: ()async{
                Navigator.of(context).pop();
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString('type','subcategory');
                sharedPreferences.setString('key','Others');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Results()) );
              },
              child: ListTile(
                title: Text('Others'),
                leading: Icon(Icons.person, color: Colors.transparent),
              ),
            )
          ],
        ),
        Divider(),
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Account()) );
          },
          child: ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person, color: Colors.grey),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Orders()) );
          },
          child: ListTile(
            title: Text('Orders'),
            leading: Icon(Icons.shopping_basket, color: Colors.grey),
          ),
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()) );
          },
          child: ListTile(
            title: Text('Cart'),
            leading: Icon(Icons.shopping_cart, color: Colors.grey),
          ),
        ),
        Divider(),
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutApp()) );
          },
          child: ListTile(
            title: Text('About'),
            leading: Icon(Icons.help, color: Colors.grey),
          ),
        ),

      ],
    );
  }
}

