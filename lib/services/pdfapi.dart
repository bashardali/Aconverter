import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
//import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as wp;
import 'dart:math';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:syncfusion_flutter_pdf/pdf.dart' as sfp;
class PdfApi{



  static Future<File> addimages(List<File> images) async {
   // File file = image;
    //Create a new PDF document.
    final sfp.PdfDocument document = sfp.PdfDocument();
//Read image data.
    int l = images.length;
    for(int x=0; x < l ; x<= l ){
      final Uint8List imageData = images[x].readAsBytesSync();
//Load the image using PdfBitmap.
      final sfp.PdfBitmap image = sfp.PdfBitmap(imageData);
//Draw the image to the PDF page.
      document.pages
          .add()
          .graphics
          .drawImage(image, const Rect.fromLTWH(0, 0, 500, 200));
    }

// Save the document.
    int max = 200;
    int r1 =  Random().nextInt(max) ;
    int r2 =  Random().nextInt(max) ;
    int r3 =  Random().nextInt(max) ;
    int r4 =  Random().nextInt(max) ;
    int r5 =  Random().nextInt(max) ;
    int r6 =  Random().nextInt(max) ;
    int r7 =  Random().nextInt(max) ;
    print(r1);
    return saveDocument(name: 'generated_pdf_$r1$r2$r2$r3$r4$r5$r6$r7' , pdf : document);


  }

  static Future<File> textfile(String text) async {
    //Create a new PDF document.
    final sfp.PdfDocument document = sfp.PdfDocument();
//Read font data.
    final Uint8List fontData = File('arial.ttf').readAsBytesSync();
//Create a PDF true type font object.
    final sfp.PdfFont font = sfp.PdfTrueTypeFont(fontData, 12);
//Draw text using ttf font.
    document.pages.add().graphics.drawString('$text', font,
        bounds: const Rect.fromLTWH(0, 0, 200, 50));

    //how to generate uniqu1 random number in flutter
    int max = 200;
    int r1 =  Random().nextInt(max) ;
    int r2 =  Random().nextInt(max) ;
    int r3 =  Random().nextInt(max) ;
    int r4 =  Random().nextInt(max) ;
    int r5 =  Random().nextInt(max) ;
    int r6 =  Random().nextInt(max) ;
    int r7 =  Random().nextInt(max) ;
    print(r1);
    return saveDocument(name: 'generated_pdf_$r1$r2$r2$r3$r4$r5$r6$r7' , pdf : document);
  }
  static Future<File> generateText(String text) async {
    const String paragraphText =
        'Adobe Systems Incorporated\'s Portable Document Format (PDF) is the de facto'
        'standard for the accurate, reliable, and platform-independent representation of a paged'
        'document. It\'s the only universally accepted file format that allows pixel-perfect layouts.'
        'In addition, PDF supports user interaction and collaborative workflows that are not'
        'possible with printed documents.';

// Create a new PDF document.
    final sfp.PdfDocument document = sfp.PdfDocument();
// Add a new page to the document.
    final sfp.PdfPage page = document.pages.add();
// Create a new PDF text element class and draw the flow layout text.
    final sfp.PdfLayoutResult layoutResult = sfp.PdfTextElement(
        text: paragraphText,
        font: sfp.PdfStandardFont(sfp.PdfFontFamily.helvetica, 12),
        brush: sfp.PdfSolidBrush(sfp.PdfColor(0, 0, 0)))
        .draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: sfp.PdfLayoutFormat(layoutType: sfp.PdfLayoutType.paginate))!;
// Draw the next paragraph/content.
    page.graphics.drawLine(
        sfp.PdfPen(sfp.PdfColor(255, 0, 0)),
        Offset(0, layoutResult.bounds.bottom + 10),
        Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));
    //how to generate uniqu1 random number in flutter
    int max = 200;
    int r1 =  Random().nextInt(max) ;
    int r2 =  Random().nextInt(max) ;
    int r3 =  Random().nextInt(max) ;
    int r4 =  Random().nextInt(max) ;
    int r5 =  Random().nextInt(max) ;
    int r6 =  Random().nextInt(max) ;
    int r7 =  Random().nextInt(max) ;


    print(r1);

    return saveDocument(name: 'generated_pdf_$r1$r2$r2$r3$r4$r5$r6$r7' , pdf : document);
  }
   static  Future<File> saveDocument ({
  required String name,
     required sfp.PdfDocument pdf
} ) async {
    final bytes = await pdf.save();
    final dir = await pp.getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    print('${dir.path}/$name');
    return file;


   }
   Future<String> filepath (File file) async{
    return file.path;
       }
    static  Future openFile(File file) async {
      final url = file.path;
                await openFile(file);
           }

}