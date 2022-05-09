import 'dart:io';

import 'package:flutter/material.dart';
class ViewImages extends StatefulWidget {
 // const ViewImages({Key? key}) : super(key: key);
   late final  List  vimages ;

  ViewImages(List<File>? images) {
    vimages = images!;
  }
   
  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: widget.vimages.length,
            itemBuilder: ( context , i)=> Image.file(widget.vimages[i]),
    shrinkWrap: true,
      )
      
    ));
  }
}
