import 'dart:convert';
import 'dart:io';

import 'package:cnn_app/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'CNN SKIN DISEASE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? image;
  final picker = ImagePicker();
  String predict_text = "";
  Color theme_color = Color.fromARGB(198, 29, 186, 181); 
  Color text_colorr = Color.fromARGB(250, 244, 243, 255);
  String apitoken = "";

  predict(File imageFile) async {    
      // open a bytestream
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      // get file length
      var length = await imageFile.length();

      // string to uri
      var uri = Uri.parse("https://b9bd-31-223-85-136.ngrok.io/predict");

      // create multipart request
      var request = http.MultipartRequest("POST", uri);

      // multipart that takes file
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      // add file to multipart
      request.files.add(multipartFile);

      // send
      var response = await request.send();
      print(response.statusCode);

      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        value = value.substring(23);
        value = value.substring(0,value.length - 2);
        setState(() {
          this.predict_text = value;
        });
        
        print(predict_text);
      });
    }

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
  

  Future<void> fetchBranchList() async {
  final url = 'https://apihacuser.bulutklinik.com/api/v3/outher/getBranches'; // API endpoint URL
  final token = apitoken;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Başarılı bir şekilde veri alındı.
    final data = json.decode(response.body);
    // "data" dizisini alın.
  List<dynamic> branches = data['data'];

  // "branch_id" değeri 47 olan veriyi bulun.
  Map<String, dynamic>? targetBranch;
  for (var branch in branches) {
    if (branch['branch_id'] == "47") {
      targetBranch = branch;
      break;
    }
  }
  if (targetBranch != null) {
    // "branch_name" değerini alın.
    String branchName = targetBranch['branch_name'];

    // Erişilen "branch_name" değerini yazdırın.
    print(branchName);
  } else {
    print("Belirtilen branch_id bulunamadı.");
  }
    
  } else {
    // İsteğin başarısız olduğu durumlar.
    print('İstek başarısız oldu. Hata kodu: ${response.statusCode}');
  }
}

  Future<String> uploadString(String data) async {
  final String apiUrl = "http://10.0.2.2:8000/uploadText/"; // Replace with your FastAPI server URL
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({"data": data}), // JSON payload with the string data
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse['data'];
  } else {
    throw Exception('Failed to upload string');
  }
}
  
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
  final imageTemp = File(image.path);
  await predict(imageTemp);
  setState(() => this.image = imageTemp);
  
  
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
    
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
  if(image == null) return;
  final imageTemp = File(image.path);
  await predict(imageTemp);
  setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          gradient: const LinearGradient(
            begin: Alignment(-0.10508774220943451, 0.9657800793647766),
            end: Alignment(-0.9657800793647766, -0.4922292232513428),
            colors: [
              Color.fromRGBO(69, 234, 170, 1), // Reversed order
              Color.fromRGBO(29, 186, 181, 1),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Settings button in the upper left corner
            Positioned(
              top: 60,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.settings),
                iconSize: 40,
                onPressed: () {
                  // Add settings logic here
                },
              ),
            ),

            Positioned(
              top: screenHeight * 0.15,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DERMAI',
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 64,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yeni Nesil Doktor',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.32,
              left: screenWidth * 0.35 -
                  screenHeight * 0.075, // Center horizontally
              child: Container(
                width: screenHeight * 0.28,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  shape: BoxShape
                      .rectangle, // You can change this to BoxShape.rectangle for a square shape
                  //Color.fromRGBO(48, 205, 175, 1),
                    image: DecorationImage(
                    image: AssetImage('assets/images/Stethoscope.png'),
                    
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.11,
              child: Column(
                children: [
                  Container(
  child: CircleAvatar(
    radius: screenHeight * 0.075,
    backgroundColor: Colors.white,
    child: ClipRect(
      child: InkWell(
        onTap: () async {
          //Galeriden geç
          await pickImage();
Future.delayed(Duration(seconds: 2), () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultPage(image: image!, predictResult: predict_text),
    ),
  );
});
        },
        child: Image.asset(
          'assets/images/Gallery1.png', // Use AssetImage to load the image asset
          width: screenHeight * 0.10,
          height: screenHeight * 0.10,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
),

                  const SizedBox(height: 4),
                  Text(
                    'Galeriden Seç',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.88 - screenHeight * 0.15,
              child: Column(
                children: [
                  CircleAvatar(
  radius: screenHeight * 0.075,
  backgroundColor: Colors.white,
  child: ClipOval(
    child: InkWell(
      onTap: () async {
        //Fotoğraf çek
        await pickImageC();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(image: image!, predictResult: predict_text),
          ),
        );
      },
      child: Image.asset(
        'assets/images/Camera1.png', // Use AssetImage to load the image asset
        width: screenHeight * 0.13,
        height: screenHeight * 0.13,
        fit: BoxFit.cover,
      ),
    ),
  ),
),

                  const SizedBox(height: 4),
                  Text(
                    'Fotoğraf Çek',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


