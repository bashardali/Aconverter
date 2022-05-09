
import 'package:aconvert/pages/drawerpages/contactus.dart';
import 'package:aconvert/pages/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:aconvert/pages/home.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:aconvert/pages/fromdocxtopdf.dart';
import 'package:aconvert/pages/fromimagestopdf.dart';
import 'package:aconvert/pages/fromscratch.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes:{

          '/home': (context)=> Home(),
          '/view': (context)=> View(''),
          '/scratch': (context)=> Scratch(),
          '/docxtopdf': (context)=> Docx(),
          '/fromimages': (context)=> FromImages(),
          '/aboutus': (context)=> Aboutus(),
          // '/login': (context)=> Loading(),

        },
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Arabic, no country code
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

    );

  }
}
