import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';
class Compress_File extends StatefulWidget {
  @override
  _Compress_FileState createState() => _Compress_FileState();
}

class _Compress_FileState extends State<Compress_File> {
  @override
  File file;
  final picker=ImagePicker();
  Future imageWithCamera() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
  }
  imageWithGallery()async{
    Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    file=File(pickedFile.path);
    print(file.lengthSync());
    final result = await FlutterImageCompress.compressWithFile(pickedFile.path.toString(),quality: 40);
    print(result.length);
  }
  upload(mcontext){
    return showDialog(context: mcontext,builder: (context){
      return SimpleDialog(
        title: Text("Choose a file",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
        children: <Widget>[
          SimpleDialogOption(
            child: Text("From camera",style: TextStyle(fontSize: 20.0,color: Colors.black),),
            onPressed: ()=>imageWithCamera(),
          ),
          SimpleDialogOption(
            child: Text("From Gallery",style: TextStyle(color: Colors.black,fontSize: 20.0),),
            onPressed: ()=>imageWithGallery(),
          ),
          SimpleDialogOption(
            child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
            onPressed: ()=>Navigator.pop(context),
          )
        ],
      );
    });
  }
  buildPage(){
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_photo_alternate,size: 260.0,color: Colors.grey,),
          RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) ,
            child: Text('Upload file',style: TextStyle(color: Colors.black,fontSize: 26.0),),
            color: Colors.green,
            highlightColor: Colors.grey,
            onPressed:()=>upload(context),
          ),
        ],
      ),
    );
  }
  Widget build(BuildContext context) {
    return buildPage();
  }
}

