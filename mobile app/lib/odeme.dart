import 'package:flutter/material.dart';

class odeme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: odemePage(),
    );
  }
}

class odemePage extends StatelessWidget {
  String odeme = "";
  @override
  Widget build(BuildContext context) {
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
          children: [
            SizedBox(height: 100,),
            SizedBox(height: 300, width: 380,
              child: Image.asset(
                'assets/images/odeme.jpeg', // Replace with the path to your first image
                height: 250, // Set the maximum height you desire
                width: 250, // Set the maximum width you desire
                fit: BoxFit.cover, // You can adjust the fit as needed
              ),
            ),
            SizedBox(height: 140,),
                SizedBox(
  width: 200,
  height: 45,
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
     odeme = "Ödeme Başarılı!";
    },
    child: Text(
      'Ödemeyi Yap',
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



