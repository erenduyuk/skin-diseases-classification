import 'dart:io';
import 'package:cnn_app/askquestionpage.dart';
import 'package:cnn_app/makeappointmentpage.dart';
import 'package:cnn_app/paymentpage.dart';
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
        backgroundColor: themeColor,
        title: Text('Sonuç Ekranı'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60,),
            SizedBox(child: Image.file(widget.image), width: 350, height: 350,),
            SizedBox(height: 20),
            
            Text(predictt,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: themeColor, // Düğmenin arkaplan rengini burada ayarlayın
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Kenarları yumuşatmak için burada değeri ayarlayın
                    ),
                  ),
                  child: Text(
                      "Randevu Al",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => makeappointmentpage()),
                    );
                  }
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: themeColor, // Düğmenin arkaplan rengini burada ayarlayın
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Kenarları yumuşatmak için burada değeri ayarlayın
                    ),
                  ),
                  child: Text(
                      "Soru Sor",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => paymentpage()),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
