import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';


class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('About US'),
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
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Text('software engineer : bashar dali \n bashatdali403@gmail.com \n +96399245348',style: TextStyle(fontSize: 25),))
          ],
        ),
      ),
    );
  }
}
