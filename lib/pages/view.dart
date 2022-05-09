import 'dart:io';
import 'dart:typed_data';
import 'package:aconvert/pages/fromdocxtopdf.dart';
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
class View extends StatefulWidget {
//const View({Key? key}) : super(key: key);
 late  String? pdfFlePath;

  View(String filepath)
  {pdfFlePath = filepath;}

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  // String? pdfFlePath;
  // final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';
  // Future<String> downloadAndSavePdf() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/sample.pdf');
  //   if (await file.exists()) {
  //     return file.path;
  //   }
  //   final response = await http.get(Uri.parse(sampleUrl));
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file.path;
  // }

  // void loadPdf() async {
  //   pdfFlePath = await downloadAndSavePdf();
  //   print('load');
  //   setState(() {});
 // }
  @override
  void initState() {
   // loadPdf();
    // TODO: implement initState
    //super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(),
      body: Container(
        child: PdfView(path: widget.pdfFlePath! ,gestureNavigationEnabled: true),
      ),
    );

  }
}
