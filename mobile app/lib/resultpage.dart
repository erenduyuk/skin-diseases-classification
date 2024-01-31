import 'dart:io';
import 'package:cnn_app/askquestionpage.dart';
import 'package:cnn_app/makeappointmentpage.dart';
import 'package:cnn_app/paymentpage.dart';
import 'package:cnn_app/randevual.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:cnn_app/main.dart';

class ResultPage extends StatefulWidget {
  final File image;
  String predictResult;

  ResultPage({required this.image, required this.predictResult});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String predictt = "aa";
  Color themeColor = Color.fromARGB(198, 29, 186, 181);
  Color textColor = Color.fromARGB(250, 244, 243, 255);

  @override
  Widget build(BuildContext context) {
    predictt = widget.predictResult;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove the shadow underneath the AppBar
        // Add other AppBar properties such as title, actions, etc.
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(child: Image.file(widget.image), width: 300, height: 250,),
            Text(
              'Sonuçlarım',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
  width: 350,
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    
    color: Color.fromRGBO(221, 221, 221, 1),
    borderRadius: BorderRadius.circular(12.0),
  ),
  child: InkWell(
    onTap: () {
      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => randevual(),
            ),
          );
    },
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            predictt,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Akne:siyah nokta ve beyaz nokta şeklinde görülen açık ve kapalı komedonlar, küçük, hassas kırmızı şişlikler, beyaz veya sarı sıkılabilir noktalar.Daha derin lezyonlar: Büyük, ağrılı kırmızı topaklar, kist benzeri fluktuasyonlu şişlikler.",
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),
),

          ),
            SizedBox(
  width: 220,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(69, 234, 170, 1), // Background color
      onPrimary: Colors.white, // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Color.fromRGBO(69, 234, 170, 1),
          width: 2.0,
        ),
      ),
    ),
    onPressed: () {
  Future.delayed(Duration(seconds: 1), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => randevual(),
      ),
    );
  });
},
    child: Text(
      'Randevu Al',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
SizedBox(
  height: 20,
),
SizedBox(
  width: 220,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromRGBO(29, 186, 181, 1), // Background color
      onPrimary: Colors.white, // Text color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Color.fromRGBO(29, 186, 181, 1),
          width: 2.0,
        ),
      ),
    ),
    onPressed: () {
      // Add the code you want to execute when the "Soru Sor" button is pressed.
    },
    child: Text(
      'Soru Sor',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

          Spacer(),
          ],
        ),
      ),
    );
  }
}
