import 'dart:io';
import 'dart:typed_data';
import 'package:aconvert/newlayouts/mydrawer.dart';
import 'package:aconvert/pages/drawerpages/contactus.dart';
import 'package:aconvert/pages/fromdocxtopdf.dart';
import 'package:aconvert/pages/frompdftodoc.dart';
import 'package:aconvert/pages/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:aconvert/pages/fromimagestopdf.dart';
import 'package:aconvert/pages/fromscratch.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';


//pdf_live_Xhr56pkKMfB6sRfwms8TtKYXn3La2CILNbKQiLXAeac
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Locale s = Locale('ar');
  late final pathController = TextEditingController();
  File _file = File(' ');
  String? _filepath ;
  //pdf view
  late String pdfassets='assets/';

  pick_file() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc','txt','TXT','png','jpg'],
    );

    if (result != null) {
      // List<File> files = result.paths.map((path) => File(path!)).toList();
      File file = File(result.files.single.path!);
      _file =  File(result.files.single.path!);
      setState(() {
        _filepath =result.files.single.path!;
      });

    } else {
      // User canceled the picker
    }
  }
  converttopdf() async{
    //Create a new PDF document.
    final PdfDocument document = PdfDocument();
//Read font data.
    final Uint8List fontData = File(_filepath!).readAsBytesSync();
//Create a PDF true type font object.
    final PdfFont font = PdfTrueTypeFont(fontData, 12);
//Draw text using ttf font.
    document.pages.add().graphics.drawString('Hello World!!!', font,
        bounds: const Rect.fromLTWH(0, 0, 200, 50));
// Save the document.
    int c = DateTime.now().microsecondsSinceEpoch;
    File('$c convertfile.pdf').writeAsBytes(document.save());
// Dispose the document.
    document.dispose();
    setState(() {
    });
  }
//view pdf



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      drawer:MyDrawer(
        semanticLabel: 'open',
        child: Column(
            children: [
              SizedBox(height: 100,),
               Container(
                   height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(30)
                  ),
                child: InkWell(
                  onTap: (){

                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text('settings',style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: InkWell(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text('Help',style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: InkWell(
                  onTap: (){
                    Get.to(()=> Aboutus());
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('About us',style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),

      ),
      // Drawer(
      //
      //   backgroundColor:Colors.redAccent ,
      //
      //   child: Column(
      //     children: [
      //       SizedBox(height: 100,),
      //       Container(
      //         color: Colors.deepOrange,
      //
      //         child: InkWell(
      //           child: Row(
      //
      //             children: [
      //               Text('settings',style: TextStyle(color: Colors.white),),
      //               Icon(Icons.file_copy_outlined , color: Colors.white,)
      //             ],
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        title: Text('Hi there!'),
        titleTextStyle: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.redAccent
                ),
                child: Center(child: Text('aconverter is a pdfconverter which can :\n'
                    '_ convert file from doc to pdf \n'
                    '_ select multiple images and put them in  one pdf file \n'
                    '_ Generate pdf file from scrach by addig text and images ' ,style: TextStyle(fontSize: 25,color: Colors.white,fontStyle: FontStyle.normal), ))),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(()=>Docx());
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('doc to pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            // InkWell(
            //   onTap: (){
            //     Get.to(()=>PdfToDoc());
            //   },
            //   child: Container(
            //       height: 60,
            //       padding: EdgeInsets.all(10),
            //       margin: EdgeInsets.all(10),
            //
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.redAccent,
            //       ),
            //
            //       child: Center(child: Text('pdf to doc' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            // ),
            // SizedBox(height: 20,),
            InkWell(
              onTap: (){   Get.to(()=>FromImages());},
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('Images to pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(()=>Scratch());
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('Scratch to pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),

          ],
        ),
      ),
    );
  }
}
