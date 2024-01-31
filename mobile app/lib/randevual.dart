import 'package:cnn_app/odeme.dart';
import 'package:flutter/material.dart';

class randevual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: randevualPage(),
    );
  }
}

class randevualPage extends StatelessWidget {
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
            Image.asset(
              'assets/images/Medicalsymbol1.png', // Replace with the path to your first image
              height: 250, // Set the maximum height you desire
              width: 250, // Set the maximum width you desire
              fit: BoxFit.cover, // You can adjust the fit as needed
            ),
            SizedBox(height: 50,), // Add some spacing between the two images
            Image.asset(
              'assets/images/doktorlar.jpeg', // Replace with the path to your second image
              height: 175, // Set the maximum height you desire
              width: 400, // Set the maximum width you desire
              fit: BoxFit.cover, // You can adjust the fit as needed
            ),
            SizedBox(height: 140,),
                SizedBox(
  width: 150,
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
  Future.delayed(Duration(seconds: 2), () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => odeme(),
      ),
    );
  });
},
    child: Text(
      'İlerle',
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



