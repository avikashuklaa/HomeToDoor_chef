import 'package:flutter/material.dart';
import 'package:hometodoor_chef/mainScreens/itemScreen.dart';

import '../model/menus.dart';


class InfoDesignWidget extends StatefulWidget {


  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  State<InfoDesignWidget> createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemScreen(model: widget.model)));
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
              Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 1.0,
              ),
              Text(
                widget.model!.menuTitle!,
                style: TextStyle(color: Colors.blueGrey,
                fontSize: 20,
                fontFamily: "Varela"),
              ),
              Text(
                widget.model!.menuInfo!,
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
