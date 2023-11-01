import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'package:transparent_image/transparent_image.dart';

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  late Timer _timer;

  double imageWidth = 300.0; // 이미지 가로 크기
  double imageHeight = 300.0; // 이미지 세로 크기

  TextEditingController ipController = TextEditingController();
  // String ipAddress = '10.0.2.15:7860';  //  안드로이드
  // String ipAddress = '192.168.68.52:7860';  // 내부망
  // String ipAddress = '127.0.0.1:7860';  // web
  // String ipAddress = '0.0.0.0:7860';  // web
    String ipAddress = '10.0.2.2:7860';  // web
  late var base64Image;

  Image? memory_image;

  late String jobtimestamp;
  late Uint8List bytes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ipController.text = ipAddress;
    loadImage();
    _timer = Timer.periodic(const Duration(seconds:1), (timer) {
      listenToServer();
    });
  }

  void loadImage() async {
    setState(() {
      isLoading= true;
    });

    try{
      final imageDataBytes= await rootBundle.load('assets/images/ana.png');
      bytes= imageDataBytes.buffer.asUint8List();

      setState(() {
        isLoading=false;
      });

    } catch(e){
      print(e.toString());

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 로딩 중 오류가 발생했습니다.')));

    }
  }

  void listenToServer() async {
    Map<String, String> header = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };

    try {
      var response = await http.get(
        Uri.parse('http://$ipAddress/sdapi/v1/progress?skip_current_image=false'),
        headers: header,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        base64Image = json['current_image'];
        jobtimestamp = json['state']['job_timestamp'];

        print(jobtimestamp);
        bytes = base64.decode(base64Image);
        // 이미지 업데이트
        setState(() {
            memory_image = Image.memory(Uint8List.fromList(bytes));
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('서버에 연결되었습니다.')));
      } else {
        setState(() {
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('서버 연결에 실패했습니다.')));
      }
    } catch (e) {
      setState(() {});
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('서버 연결 중 오류가 발생했습니다.')));
    }
  }

    @override
  void dispose() {
    ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 화면 부드러운 전환을 위해 FadeInImage 위젯 사용
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: '',
              width: imageWidth, // 가로 사이즈 적용
              height: imageHeight, // 세로 사이즈 적용
              fit: BoxFit.cover, // 넓이 또는 높이에 맞게 조정 (선택사항)
              imageErrorBuilder: (context, error, stackTrace) {
                return memory_image != null
                    ? Image.memory(bytes, width:imageWidth , height:imageHeight)
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}