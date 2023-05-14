import 'package:flutter/material.dart';
import 'package:hometodoor_chef/global/global.dart';
import 'package:hometodoor_chef/mainScreens/earnings_screen.dart';
import 'package:hometodoor_chef/mainScreens/history_screen.dart';
import 'package:hometodoor_chef/mainScreens/new_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../mainScreens/home_screen.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [

                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                    color: Color(0xff354f52),
                    fontSize: 25.0,
                    fontFamily:"Lobster",
                  ),
                )
              ],
            ),
          ),
          //body drawer
          SizedBox(height: 12.0,),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                Divider(
                  height: 10.0,
                  color: Colors.blueGrey[50],
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Color(0xff006d77),
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.money,
                    color: Color(0xff006d77),
                  ),
                  title: Text(
                    "My Earnings",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>EarningsScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Color(0xff006d77),
                  ),
                  title: Text(
                    "New Orders",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>NewOrdersScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_shipping,
                    color: Color(0xff006d77),
                  ),
                  title: Text(
                    "History-Orders",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>HistoryScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Color(0xff006d77),
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                      firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
