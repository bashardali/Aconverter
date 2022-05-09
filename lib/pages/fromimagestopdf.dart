import 'dart:io';
import 'package:aconvert/pages/view.dart';
import 'package:aconvert/pages/viewimages.dart';
import 'package:aconvert/services/pdfapi.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xid/xid.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';

import 'package:pdf/pdf.dart';
class FromImages extends StatefulWidget {
  const FromImages({Key? key}) : super(key: key);

  @override
  _FromImagesState createState() => _FromImagesState();
}

class _FromImagesState extends State<FromImages> {
 final picker = ImagePicker();
 final pdf =pw.Document();
 bool isSaved = false;
 bool isCreated = false;

  List<File>? images;
  String? _file;
  String? pdfFlePath;
 // getImageFromGallery() async {
 //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
 //   setState(() {
 //     if (pickedFile != null) {
 //       images!.add(File(pickedFile.path));
 //     } else {
 //       print('No image selected');
 //     }
 //   });
 // }
 pick_images() async{
   FilePickerResult? result = await FilePicker.platform.pickFiles(
     allowMultiple: true,
     type: FileType.custom,
     allowedExtensions: [ 'jpg', 'jpeg' , 'jfif' , 'pjpeg' ,'pjp','rtf','png','JFIF','PNG'],
   );

   if (result != null) {
     List<File> files = result.paths.map((path) => File(path!)).toList();
     images = files;
   } else {
     // User canceled the picker
   }
   setState(() {});
 }
 CreatePdf(){
   for (var img in images!) {
     final image = pw.MemoryImage(img.readAsBytesSync());
     pdf.addPage(pw.Page(
         pageFormat:PdfPageFormat.a4 ,
         build: (context) => pw.Center(child: pw.Image(image) )
     ));
     setState(() {
       isCreated=true;

     });

   }
 }
 savePDF() async {
   try {
     await Permission.storage.request();
     final directory = await getApplicationDocumentsDirectory();
     final dir = await getExternalStorageDirectory();
     var xid = Xid();
     final file = File('$directory/pdfimages$xid.pdf');
     pdfFlePath = '$directory/pdfimages$xid.pdf';
     await file.writeAsBytes(await pdf.save());
     showPrintedMessage('success', 'saved to documents');
     isSaved = true;
   } catch (e) {
     showPrintedMessage('error', e.toString());
   }
   setState(() {  });

 }
 showPrintedMessage(String title, String msg) {
   Flushbar(
     title: title,
     message: msg,
     duration: Duration(seconds: 3),
     icon: Icon(
       Icons.info,
       color: Colors.blue,
     ),
   )..show(context);
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Images to pdf'),
        titleTextStyle: TextStyle(color: Colors.white70 , fontSize: 25 , fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            InkWell(
              onTap:  pick_images,
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87,
                  ),

                  child: Center(child: Text('Select images' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            images == null ? Container() :
            InkWell(
              onTap:() async {
                CreatePdf();
              }
              ,
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('Convert' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            isCreated == false ? Container() :
            InkWell(
              onTap: () async{
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                }
                savePDF();

              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.yellow,
                  ),

                  child: Center(child: Text('Save pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            pdfFlePath == null ? Container() :
            InkWell(
              onTap: (){
                Get.to(()=>View(pdfFlePath!));

              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orangeAccent,
                  ),

                  child: Center(child: Text('Show generated pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),

            SizedBox(height: 5,),


          ],
        ),
      ),
    );
  }
}
