import 'dart:io';
import 'package:aconvert/pages/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:aconvert/services/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

//final clientId = '2720faeb-aa0f-46ee-aa0a-8bf7559268fc';
//final secret = '65cc9d8e63d2a01be5dd5abde8cbc970';
//var configuration = Configuration(secret, clientId);
class PdfToDoc extends StatefulWidget {
  const PdfToDoc({Key? key}) : super(key: key);

  @override
  _PdfToDocState createState() => _PdfToDocState();
}

class _PdfToDocState extends State<PdfToDoc> {
//view pdf
  String? docFilePath;
  String? docFilename;
  String? docFiledata;
  File? _file;
  Map? responsmap;
  String? downloadurl ;
  String? downloaddir;
  String? downloadfilename;

  late final pathController = TextEditingController();


  pick_file() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc','png','pdf','rtf','docx','dot','dotx','wps','wpd','wri','log'],
    );

    if (result != null) {
      // List<File> files = result.paths.map((path) => File(path!)).toList();
      File file = File(result.files.single.path!);
      _file =  File(result.files.single.path!);
      setState(() {
        docFilePath =result.files.single.path!;
        docFilename = _file?.path.split('/').last;
        final bytes = File(_file!.path).readAsBytesSync();

        docFiledata = base64Encode(bytes);
        //  String? fileInByte = _file?.readAsBytesSync().toString();
        //  docFiledata = base64Decode(fileInByte!) as String?;



      });

    } else {
      // User canceled the picker
    }
    print("doc file name : $docFilename ");
    print("-------------------------------");
    print("doc file path : $docFilePath ");
    print("-------------------------------");
    print("doc file base64 data : $docFiledata ");
  }
  // convert to pdf api

  Future postfile() async{
    String url = 'https://v2.convertapi.com/convert/doc/to/pdf?Secret=11zJ9nRSn56BMPQH&Token=636106935';
    final Uri uri  = Uri.parse(url);
    final String? my_file = docFilename;
    final String? data = docFiledata;

    final body = {

      "Parameters": [
        {

          "Name": "File",
          "FileValue": {
            "Name": "${docFilename}" ,
            "Data":
            "${docFiledata}"
          }
        },
        {
          "Name": "StoreFile",
          "Value": true
        }
      ]

    };

    http.Response response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json"
        }

    );
    Map responsebody = json.decode(response.body) ;
    responsmap =responsebody;
    print('Response status: ${response.statusCode}');
    print('------------------------------------');
    print('Response body: ${response.body}');
    print('------------------------------------');
    print('Response body: ${responsebody}');
    print('------------------------------------');
    downloadurl = responsmap!['Files'][0]['Url'];
    downloadfilename = responsmap!['Files'][0]['FileName'];
    downloaddir = docFilePath;
    print("downloadurl : $downloadurl");
    print('------------------------------------');
    print("downloadfilename : $downloadfilename");
    print('------------------------------------');
    print("downloaddir : $downloaddir");

  }

  // download () async{
  //
  //    print(responsmap!['Files'][0]['Url']);
  //
  //    String filename =  responsmap!['Files'][0]['FileName'];
  //    String durl = downloadurl!;
  //
  //  //  String downloaddir  = '/storage/emulated/0/Download/';
  //
  //   // downloadFile(durl,filename,downloaddir);
  //    // final taskId = await FlutterDownloader.enqueue(
  //    //   url: Downloadurl!,
  //    //   savedDir: '/storage/emulated/0/Download/',
  //    //   showNotification: true, // show download progress in status bar (for Android)
  //    //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  //    // );
  //
  //
  // }
  Future<String> downloadFile() async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    print("downloadurl : $downloadurl");
    print('------------------------------------');
    print("downloadfilename : $downloadfilename");
    print('------------------------------------');
    print("downloaddir : $downloaddir");

    try {
      myUrl = downloadurl!;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '/storage/emulated/0/Download/$downloadfilename';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        print('SUCCESS');
      }
      else
        filePath = 'Error code: '+response.statusCode.toString();
      print('ERROR1');
    }
    catch(ex){
      filePath = 'Can not fetch url';
      print('ERROR2');
    }

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('from pdf to doc'),
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
              onTap: pick_file,
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('select file ' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(()=>View(docFilePath!));
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('show selected file' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            //convert
            InkWell(
              onTap: postfile,
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
            SizedBox(height: 20,),
            InkWell(
              onTap: downloadFile,
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.redAccent,
                  ),

                  child: Center(child: Text('Download' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),


          ],
        ),
      ),
    );
  }
}

