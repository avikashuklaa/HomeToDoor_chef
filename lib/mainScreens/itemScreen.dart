import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hometodoor_chef/widgets/my_drawer.dart';
import 'package:hometodoor_chef/widgets/text_widget_header.dart';

import '../global/global.dart';
import '../model/items.dart';
import '../model/menus.dart';
import '../uploadscreens/items_upload.dart';
import '../uploadscreens/menu_upload.dart';
import '../widgets/info_design.dart';
import '../widgets/items_design.dart';
import '../widgets/progress_bar.dart';

class ItemScreen extends StatefulWidget {

  final Menus? model;
  ItemScreen({this.model});


  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2ec4b6),
                Color(0xff2ec4b6),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsUploadScreen(model: widget.model)));
              },
              icon: Icon(Icons.library_add), color: Color(0xff15616d),)
        ],
      ),
      drawer: MyDrawer(

      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true,
              delegate: TextWidgetHeader(
                title: widget.model!.menuTitle.toString() + " items"
              )),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.
            collection("chefs").
            doc(sharedPreferences!.getString("uid")).
            collection("Menu").doc(widget.model!.menuID)
                .collection("items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                child: Center(
                  child: circularProgress(),
                ),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Items model = Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return ItemsDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
