import 'package:flutter/material.dart';
import 'package:hometodoor_chef/mainScreens/itemScreen.dart';
import 'package:hometodoor_chef/mainScreens/item_detail_screen.dart';

import '../model/items.dart';
import '../model/menus.dart';


class ItemsDesignWidget extends StatefulWidget {


  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Color(0xffcbf3f0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 295,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.blueGrey[50],
              ),
              SizedBox(height: 10,),
              Text(
                widget.model!.title!,
                style: TextStyle(color: Colors.blueGrey,
                    fontSize: 22,
                  fontWeight: FontWeight.bold
                    ),
              ),
              SizedBox(height: 5,),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 250.0,
                fit: BoxFit.fitWidth,
              ),
              //SizedBox(height: 3.0,),
              // Text(
              //   widget.model!.info!,
              //   style: TextStyle(color: Colors.blueGrey,
              //       fontSize: 17,
              //     fontWeight: FontWeight.bold
              //      ),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
