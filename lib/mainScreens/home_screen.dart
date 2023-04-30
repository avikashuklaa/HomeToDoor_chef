import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hometodoor_chef/authentication/auth_screen.dart';
import 'package:hometodoor_chef/global/global.dart';
import 'package:hometodoor_chef/uploadscreens/menu_upload.dart';
import 'package:hometodoor_chef/widgets/info_design.dart';
import 'package:hometodoor_chef/widgets/my_drawer.dart';
import 'package:hometodoor_chef/widgets/progress_bar.dart';

import '../model/menus.dart';
import '../widgets/text_widget_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffff99c8),
                Color(0xff023e8a),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
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
                Navigator.push(context, MaterialPageRoute(builder: (c)=>MenuUploadScreen()));
              },
              icon: Icon(Icons.post_add))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true,
              delegate: TextWidgetHeader(title: "Menu")),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("chefs").doc(sharedPreferences!.getString("uid"))
                .collection("Menu").orderBy("publishedDate", descending: true).
            snapshots(),
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
                  Menus model = Menus.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return InfoDesignWidget(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          )
        ],
      )
    );
  }
}
