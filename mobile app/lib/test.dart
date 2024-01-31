import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendMessagePage extends StatefulWidget {
  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final TextEditingController authKeyController = TextEditingController();
  final TextEditingController identityNoController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController questionIdController = TextEditingController();
  String responseMessage = "";

  Future<Map<String, dynamic>> sendMessage() async {
    final url = Uri.parse("https://apihacuser.bulutklinik.com/api/v3/outher/message");

    final headers = {
      "Authorization": "Bearer ${authKeyController.text}",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    final body = {
      "identityNo": identityNoController.text,
      "message": messageController.text,
      "questionId": int.parse(questionIdController.text),
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
              controller: authKeyController,
              decoration: InputDecoration(labelText: 'Auth Key'),
            ),
            TextField(
              controller: identityNoController,
              decoration: InputDecoration(labelText: 'Identity No'),
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Message'),
            ),
            TextField(
              controller: questionIdController,
              decoration: InputDecoration(labelText: 'Question ID'),
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

void main() {
  runApp(MaterialApp(
    home: SendMessagePage(),
  ));
}
