import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class askquestionpage extends StatefulWidget {
  @override
  _askquestionpageState createState() => _askquestionpageState();
}

class _askquestionpageState extends State<askquestionpage> {
  final TextEditingController identityNoController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String responseMessage = "";

  Future<Map<String, dynamic>> sendMessage() async {
    final url = Uri.parse("https://apihacuser.bulutklinik.com/api/v3/outher/message");

    final headers = {
      "Authorization": "Bearer YOUR_AUTH_KEY", // Sabit authKey
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final body = {
      "identityNo": identityNoController.text,
      "message": messageController.text,
      "questionId": 6, // Sabit questionId
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('İstek başarısız: ${response.reasonPhrase}');
    }
  }

  void _handleSendMessage() async {
    try {
      final response = await sendMessage();
      setState(() {
        responseMessage = response.toString();
      });
    } catch (e) {
      setState(() {
        responseMessage = "Hata: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mesaj Gönder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: identityNoController,
              decoration: InputDecoration(labelText: 'TC Kimlik Numaranızı Giriniz'),
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Sorunuzu Giriniz'),
            ),
            ElevatedButton(
              onPressed: _handleSendMessage,
              child: Text('Gönder'),
            ),
            Text(responseMessage),
          ],
        ),
      ),
    );
  }
}
