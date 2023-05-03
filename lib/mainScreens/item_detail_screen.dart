import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_chef/global/global.dart';
import 'package:hometodoor_chef/mainScreens/home_screen.dart';
import 'package:hometodoor_chef/widgets/simple_app_bar.dart';

import '../model/items.dart';


class ItemDetailsScreen extends StatefulWidget {
 final Items? model;
 ItemDetailsScreen({this.model});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {

  TextEditingController counterTextEditingController = TextEditingController();

  deleteItem(String itemID)
  {
    FirebaseFirestore.instance.collection("chefs")
        .doc(sharedPreferences!.getString("uid"))
        .collection("Menu").doc(widget.model!.menuID!)
        .collection("items").doc(itemID).delete()
        .then((value) {
           FirebaseFirestore.instance
           .collection("items").doc(itemID)
               .delete();

           Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
           Fluttertoast.showToast(msg: "Item deleted successfully");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name"),),
      body: Column(

        children: [
          Image.network(widget.model!.thumbnailUrl.toString(), height: 300,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, fontFamily: "VarelaRound"),
            ),         ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.info.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, fontFamily: "VarelaRound"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             "₹ " + widget.model!.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "VarelaRound"),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: () {
                  deleteItem(widget.model!.itemID!);
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2ec4b6),
                      Color(0xff2ec4b6),
                    ],
                    begin: const FractionalOffset(10.0, 10.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),

                ),
                width: MediaQuery.of(context).size.width - 50,

                height: 50,
                child: Center(
                  child: Text(
                    "Delete the item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
