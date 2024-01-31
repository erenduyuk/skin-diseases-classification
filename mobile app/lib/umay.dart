import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove the title text
        title: null,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sonuçların',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 450,
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(69, 234, 170, 1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(69, 234, 170, 1),
              ),
              child: Text(
                'Randevu Al',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(29, 186, 181, 1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(29, 186, 181, 1),
              ),
              child: Text(
                'Soru Sor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}