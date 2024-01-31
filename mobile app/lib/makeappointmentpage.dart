import 'package:flutter/material.dart';

class makeappointmentpage extends StatefulWidget {
  @override
  _makeappointmentpage createState() => _makeappointmentpage();
}

class _makeappointmentpage extends State<makeappointmentpage> {
  Color themeColor = Color.fromARGB(198, 29, 186, 181);
  Color textColor = Color.fromARGB(250, 244, 243, 255);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text('İkinci Ekran'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bu ikinci ekranın içeriği.'),
            ElevatedButton(
              onPressed: () {
                // İkinci ekranı kapatmak ve bir önceki ekrana dönmek için Navigator'ı kullanın
                Navigator.pop(context);
              },
              child: Text('Geri Dön'),
            ),
          ],
        ),
      ),
    );
  }
}
