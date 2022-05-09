// // Import dependencies
// import 'dart:typed_data';
// import 'package:aspose_words_cloud/aspose_words_cloud.dart';
// import 'dart:convert';
// import 'dart:io';
// final clientId = '2720faeb-aa0f-46ee-aa0a-8bf7559268fc';
// final secret = '65cc9d8e63d2a01be5dd5abde8cbc970';
//
// class PdfOption extends SaveOptionsData{
// }
//
//  class Api {
//   var configuration = Configuration(secret, clientId);
//
//
// // Convert PDF to Word
//  ConvertToWord(File file) async{
//   print('start');
//   var wordsApi = WordsApi(configuration);
//   var bytes = File(file.path).readAsBytesSync();
//   var request = ConvertDocumentRequest(ByteData.view(bytes.buffer), 'docx');
//     wordsApi.convertDocument(request);
//   print('end');
//  }
//   // Convert DOCX to PDF if we have a document in the Storage
//  //  ConvertToPDF() async{
//  //  var wordsApi = WordsApi(configuration);
//  // // var PdfOption = SaveOptionsData();
//  //   var pdfSaveOptions = PdfOption();
//  //   pdfSaveOptions.fileName = 'dest.pdf';
//  // // SaveOptionsData().saveFormat ="pdf";
//  //   pdfSaveOptions.saveFormat= "pdf";
//  //   var saveAsRequest = SaveAsRequest('source.docx', pdfSaveOptions);
//  //   wordsApi.saveAs(saveAsRequest);
//  //  }
//
//  // Upload file to cloud
//  UploadToCloud(File file ) async{
//   var wordsApi = WordsApi(configuration);
//   var localFileContent = await (File(file.path).readAsBytes());
//  var uploadRequest = UploadFileRequest(ByteData.view(localFileContent.buffer), 'file_test.docx');
//  await wordsApi.uploadFile(uploadRequest);
//  }
//
// // Save file as pdf in cloud
//   SavePdfInCloud() async{
//    var wordsApi = WordsApi(configuration);
//    var saveOptionsData = PdfSaveOptionsData()
//     ..fileName = 'destStoredInCloud.pdf';
//    var saveAsRequest = SaveAsRequest('fileStoredInCloud.docx', saveOptionsData);
//    await wordsApi.saveAs(saveAsRequest);
//   }
//
// // Convert DOCX to HTML with advanced options
// //   ConvertDOCXtoHTML() async{
// //    var wordsApi = WordsApi(configuration);
// //    var htmlSaveOptions = HtmlFixedSaveOptionsData();
// //    htmlSaveOptions.exportEmbeddedCss = true;
// //    htmlSaveOptions.cssClassNamesPrefix = 'aspose_';
// //
// //    htmlSaveOptions.pageIndex = 2;
// //    htmlSaveOptions.pageCount = 3;
// //    htmlSaveOptions.jpegQuality = 90;
// //    htmlSaveOptions.fileName = 'sample.html';
// //
// //    htmlSaveOptions.saveFormat = 'html';
// //    var saveAsRequest = SaveAsRequest('sample.docx', htmlSaveOptions);
// //    wordsApi.saveAs(saveAsRequest);
// //   }
//
//
//  }