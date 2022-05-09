import 'dart:io';
import 'package:aconvert/pages/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:aconvert/services/api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:dio/dio.dart';




class Docx extends StatefulWidget {
  const Docx({Key? key}) : super(key: key);

  @override
  _DocxState createState() => _DocxState();
}

class _DocxState extends State<Docx> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//view pdf
  String? docFilePath;
  String? docFilename;
  String? docFiledata;
  File? _file;
  Map? responsmap;
  String? downloadurl ;
  String? downloaddir;
  String? downloadfilename;
  bool isdownloaded=false;

  late final pathController = TextEditingController();
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  // Future download2( String url, String savePath) async {
  //   try {
  //     var dio =Dio();
  //     var response = await dio.get(
  //       url,
  //       onReceiveProgress: showDownloadProgress,
  //       //Received data with List<int>
  //       options: Options(
  //           responseType: ResponseType.bytes,
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! < 500;
  //           }),
  //     );
  //     print(response.headers);
  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     // response.data is List<int> type
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //   } catch (e) {
  //     print(e);
  //   }
  // }
/// pick file to set file name, path
  pick_file() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc','png','jpg','pdf','PDF','rtf','docx','dot','dotx','wps','wpd','wri','log'],
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

/// api post method
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
            "Data": "${docFiledata}"
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
    setState(() {
      downloadurl = responsmap!['Files'][0]['Url'];
      downloadfilename = responsmap!['Files'][0]['FileName'];
      downloaddir = docFilePath;
      print("downloadurl : $downloadurl");
      print('------------------------------------');
      print("downloadfilename : $downloadfilename");
      print('------------------------------------');
      print("downloaddir : $downloaddir");
    });


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
 //   // downloadFil(durl,filename,downloaddir);
 //    // final taskId = await FlutterDownloader.enqueue(
 //    //   url: Downloadurl!,
 //    //   savedDir: '/storage/emulated/0/Download/',
 //    //   showNotification: true, // show download progress in status bar (for Android)
 //    //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
 //    // );
 //
 //
 // }
/// download and save method from api url
  Future downloadFile1() async {
    File file;
    String filePath = '';
    String myUrl = '';
    print("downloadurl : $downloadurl");
    print('------------------------------------');
    print("downloadfilename : $downloadfilename");
    print('------------------------------------');
    print("downloaddir : $downloaddir");
 var dio = Dio();
      myUrl = downloadurl!;
      dio.download(downloadurl!, '/storage/emulated/0/Download/$downloadfilename' );
       isdownloaded= true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('doc to pdf'),
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
            SizedBox(height: 20,),
            InkWell(
              onTap: pick_file,
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87,
                  ),

                  child: Center(child: Text('Select file' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),


                //convert
            docFilename ==null && docFilePath ==null ?  Container() :
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

                  child: Center(child: Text('Convert' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            downloadurl == null ? Container() :
            InkWell(
              onTap: ()  async{

                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                }
                downloadFile1();
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),

                  child: Center(child: Text('Download' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),
            SizedBox(height: 20,),
            isdownloaded==false ? Container() :
            InkWell(
              onTap: (){
                 if(isdownloaded==true){
                   Get.to(()=>View('/storage/emulated/0/Download/$downloadfilename'));}
                else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("there was no file downloaded yet"),
                    ),
                  );
                }
              },
              child: Container(
                  height: 60,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),

                  child: Center(child: Text('Show Downloaded file' ,style: TextStyle(fontSize: 30,color: Colors.white), ))),
            ),


          ],
        ),
      ),
    );
  }
}

