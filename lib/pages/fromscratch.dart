import 'package:aconvert/pages/view.dart';
import 'package:flutter/material.dart';
import 'package:aconvert/services/pdfapi.dart';
import 'package:pdf/pdf.dart';
import 'package:get/get.dart';
class Scratch extends StatefulWidget {
  const Scratch({Key? key}) : super(key: key);

  @override
  _ScratchState createState() => _ScratchState();
}

class _ScratchState extends State<Scratch> {
  String? filepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('build your pdf'),
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
              onTap: () async{
                final pdffile = await PdfApi.generateText('simple pdf');
                  filepath = pdffile.path;
                  print(filepath);

              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('simple pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () async{
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('generate pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: () async{
                Get.to(()=>View(filepath!));

              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('show simple pdf' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){

              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('show selected images' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){},
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('convert' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 5,),


          ],
        ),
      ),
    );
  }
}
