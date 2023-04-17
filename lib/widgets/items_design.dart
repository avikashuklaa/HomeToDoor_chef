import 'package:flutter/material.dart';
import 'package:hometodoor_chef/mainScreens/itemScreen.dart';

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
        //Navigator.push(context, MaterialPageRoute(builder: (c) => ItemScreen(model: widget.model)));
      },
      splashColor: Colors.red,
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
              SizedBox(height: 1,),
              Text(
                widget.model!.title!,
                style: TextStyle(color: Colors.blueGrey,
                    fontSize: 25,
                    fontFamily: "Varela"),
              ),
              SizedBox(height: 2,),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 2.0,),
              Text(
                widget.model!.info!,
                style: TextStyle(color: Colors.blueGrey,
                    fontSize: 12,
                    fontFamily: "Varela"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
