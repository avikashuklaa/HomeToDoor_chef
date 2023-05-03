import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_chef/global/global.dart';

import 'home_screen.dart';

class EarningsScreen extends StatefulWidget {

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {

  double sellerTotalEarnings = 0;

  retrieveSellerEarnings() async{
    await FirebaseFirestore.instance
        .collection("chefs")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap) {

          setState(() {
            sellerTotalEarnings = double.parse(snap.data()!["earnings"].toString());
          });
        });
  }

  @override
  void initState() {
    super.initState();

    retrieveSellerEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeff7f6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹" + sellerTotalEarnings!.toString(),
                style: TextStyle(
                  fontSize: 70,
                  color: Color(0xff006d77),

                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Total Earnings",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff15616d),
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,

                ),
              ),

              SizedBox(
                height: 15,
                width: 170,
                child: Divider(
                  color: Color(0xff15616d),
                  thickness: 1.5,
                ),
              ),
              SizedBox(height: 40,),

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c) =>const HomeScreen()));
                },
                child: Card(
                  color: Color(0xff2ec4b6),
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 140),
                  child: ListTile(
                    //leading:
                    title:const Text(
                      "Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
