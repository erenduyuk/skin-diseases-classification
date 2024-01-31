import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class paymentpage extends StatefulWidget {
  @override
  _paymentpageState createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController identityNoController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpMonthController = TextEditingController();
  final TextEditingController cardExpYearController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  String responseMessage = "";
  String apitoken = "";


  Future<void> login() async {
  final apiUrl = 'https://apihacuser.bulutklinik.com/api/v3/general/connectApi';

  final Map<String, String> requestData = {
    'apiClientId': '9a4ba054-16ec-4d90-9ae0-5c340788e6cd',
    'apiSecretKey': 'ROZT49Yr49bgs32UDEipLqs0Q1ByIqt6LL0qXmto',
    'apiUserName': 'hackathon3@bulutklinik.com',
    'apiUserPassword': 'bulutklinik2023.spikes',
    'loginMode': 'email',
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    body: requestData,
  );

  if (response.statusCode == 200) {
    // API ile başarılı bir şekilde bağlandı. Yanıtı işleyin.
    final responseBody = response.body;
    // JSON dizesini bir Dart haritasına çözün.
  Map<String, dynamic> data = json.decode(responseBody);

  // "access_token" değerine erişin.
  String accessToken = data['data']['access_token'];
    print("API'ye bağlanıldı.");
  // Erişilen "access_token" değerini yazdırın.
    apitoken = accessToken;
    //print('API yanıtı: $responseBody');
  } else {
    // Hata durumlarını ele alın.
    print('API isteği başarısız oldu. Hata kodu: ${response.statusCode}');
  }
}





  Future<Map<String, dynamic>> createQuestionAndMakePayment() async {
    final questionUrl = Uri.parse("https://apihacuser.bulutklinik.com/api/v3/outher/question");
    final questionHeaders = {
      "Authorization": "Bearer YOUR_AUTH_KEY", // Soru oluşturma için Auth Key'i burada değiştirin
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    final questionBody = {
      "doctorId": 158530,
      "patientInfo": {
        "name": nameController.text,
        "surname": surnameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "birthdate": birthdateController.text,
        "identityNo": identityNoController.text,
      },
    };

    final responseQuestion = await http.post(
      questionUrl,
      headers: questionHeaders,
      body: jsonEncode(questionBody),
    );

    if (responseQuestion.statusCode == 200) {
      final Map<String, dynamic> questionData = json.decode(responseQuestion.body);

      final paymentUrl = Uri.parse("https://apihacuser.bulutklinik.com/api/v3/payments/insurancePayment");
      final paymentHeaders = {
        "Authorization": "Bearer YOUR_AUTH_KEY", // Ödeme için Auth Key'i burada değiştirin
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      final paymentBody = {
        "hashedData": questionData["hashedData"],
        "insuranceProcessId": 4,
        "cardInfo": {
          "cardHolder": cardHolderController.text,
          "cardNumber": cardNumberController.text,
          "cardExpMonth": cardExpMonthController.text,
          "cardExpYear": cardExpYearController.text,
          "cardCvv": cardCvvController.text,
        },
        "cardFullYear": "2037-09-18",
        "termsAccept": "1",
        "is3D": "0",
        "discountCode": "amet",
      };

      final responsePayment = await http.post(
        paymentUrl,
        headers: paymentHeaders,
        body: jsonEncode(paymentBody),
      );

      if (responsePayment.statusCode == 200) {
        final Map<String, dynamic> paymentData = json.decode(responsePayment.body);
        return paymentData;
      } else {
        throw Exception('Ödeme işlemi başarısız: ${responsePayment.reasonPhrase}');
      }
    } else {
      throw Exception('Soru oluşturma işlemi başarısız: ${responseQuestion.reasonPhrase}');
    }
  }

  void _handleCreateQuestionAndMakePayment() async {
    try {
      final response = await createQuestionAndMakePayment();
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
      title: Text('Ödeme Ekranı'),
    ),
    body: SingleChildScrollView( // SingleChildScrollView eklenmiş
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Ad'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Soyad'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Telefon'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: birthdateController,
              decoration: InputDecoration(labelText: 'Doğum Tarihi'),
            ),
            TextField(
              controller: identityNoController,
              decoration: InputDecoration(labelText: 'Kimlik Numarası'),
            ),
            TextField(
              controller: cardHolderController,
              decoration: InputDecoration(labelText: 'Kart Sahibi'),
            ),
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Kart Numarası'),
            ),
            TextField(
              controller: cardExpMonthController,
              decoration: InputDecoration(labelText: 'Son Kullanma Ayı'),
            ),
            TextField(
              controller: cardExpYearController,
              decoration: InputDecoration(labelText: 'Son Kullanma Yılı'),
            ),
            TextField(
              controller: cardCvvController,
              decoration: InputDecoration(labelText: 'CVV'),
            ),
            ElevatedButton(
              onPressed: () async {
                await login();
                
              },
              child: Text('Ödemeyi Yap'),
            ),
            Text(responseMessage),
          ],
        ),
      ),
    ),
  );
}

}
