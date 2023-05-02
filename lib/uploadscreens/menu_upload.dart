import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_chef/mainScreens/home_screen.dart';
import 'package:hometodoor_chef/widgets/progress_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import '../widgets/error_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {

  XFile? imageXFile;
  final ImagePicker _picker= ImagePicker();
  bool uploading=false;

  TextEditingController shortInfocontroller=TextEditingController();
  TextEditingController titlecontroller=TextEditingController();

  String uniqueIdname=DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen(){
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
          "Add New Menu",
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
          },
        )
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shop_2, size: 200.0, color: Color(0xffcce3de),),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff6bd60)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>
                    (
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))
                ),
                  onPressed: () {
                        takeImage(context);

                  },
                  child: Text("Add",
                  style: TextStyle(color: Colors.white,
                  fontSize: 18.0))),
            ],
          )
        )
      ),
    );



  }

  takeImage(mContext){
    return showDialog(
        context: mContext,
        builder: (context){
          return SimpleDialog(
            title: Text("Menu Image", style: TextStyle(color: Color(0xff6b9080), fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text(
                    "Capture with camera",
                  style: TextStyle(color: Color(0xffa4c3b2), fontWeight: FontWeight.bold),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Pick from gallery",
                  style: TextStyle(color: Color(0xffa4c3b2), fontWeight: FontWeight.bold),
                ),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xffa4c3b2), fontWeight: FontWeight.bold),
                ),
                onPressed: ()=>Navigator.pop(context),
              )
            ],
          );
        },
    );
  }

  captureImageWithCamera() async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async{
    Navigator.pop(context);
    imageXFile=await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }
  menuUploadFormScreen(){
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
            "Uploading New Menu",
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              clearMenuUploadForm();
              //Navigator.push(context,MaterialPageRoute(builder: (c)=>HomeScreen()));
            },
          ),
        actions: [
            TextButton(
                onPressed: uploading ? null : ()=> validateUploadForm(),
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Color(0xff354f52),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,

                  ),
                ),

            )
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    )
                  ),
                ),

              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.title, color: Color(0xff83c5be),),
            title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    hintText: "Menu Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                )
            ),
          ),
           Divider(color: Colors.grey[350],
           thickness: 1,),
           ListTile(
            leading: Icon(Icons.perm_device_information, color: Color(0xff83c5be),),
             title: Container(
               width: 250,
               child: TextField(
                 style: TextStyle(color: Colors.black),
                 controller: shortInfocontroller,
                 decoration: InputDecoration(
                   hintText: "Menu Info",
                   hintStyle: TextStyle(color: Colors.grey),
                   border: InputBorder.none,
                 ),
               )
             ),
          ),

        ],
      ),
    );
  }

//to clear the form when user presses the back button after adding one dish. So that he could add new dish after coming to this page again.

  clearMenuUploadForm(){
    setState(() {
      shortInfocontroller.clear();
      titlecontroller.clear();
      imageXFile=null;
    });
  }

  validateUploadForm() async {
     if(imageXFile != null){
      if(shortInfocontroller.text.isNotEmpty && titlecontroller.text.isNotEmpty){
        setState(() {
          uploading=true;
        });

        //upload image
        String downloadurl = await uploadImage(File(imageXFile!.path));

        //save infor to firebase
        saveInfo(downloadurl);
      }

      else{
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Please provide the necessary information to proceed!",
              );
            }
        );
      }
    }

    else{
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: "Please upload an image to proceed!",
            );
          }
      );

    }
  }

  uploadImage(mImageFile) async{
    storageRef.Reference reference= storageRef.FirebaseStorage.instance.ref().child("Menu");
    storageRef.UploadTask uploadTask= reference.child(uniqueIdname+".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() {});

    String downloadUrl=await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;

  }

  saveInfo(String downloadUrl){
    final ref = FirebaseFirestore.instance.collection("chefs").doc(sharedPreferences!.getString("uid")).collection("Menu");

    ref.doc(uniqueIdname).set({
      "menuID" : uniqueIdname,
      "chefUID" : sharedPreferences!.getString("uid"),
      "menuTitle" : titlecontroller.text.toString(),
      "menuInfo" : shortInfocontroller.text.toString(),
      "publishedDate" : DateTime.now(),
      "status": "available",
      "thumbnailurl": downloadUrl,
    });

    clearMenuUploadForm();

    setState(() {
      uniqueIdname=DateTime.now().millisecondsSinceEpoch.toString();
      uploading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile==null ? defaultScreen() : menuUploadFormScreen();
  }
}
