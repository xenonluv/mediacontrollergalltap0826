import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ImagePanel extends StatefulWidget {
  const ImagePanel({Key? key}) : super(key: key);

  @override
  State<ImagePanel> createState() => _ImagePanelState();
}

class _ImagePanelState extends State<ImagePanel> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KCTI Introduce Tech'),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ImageButtonItem(
                    imagePath: 'assets/images/chair.png',
                    borderRadius: 38.0,
                    width: 180,
                    height: 250,
                    message: 'Chair: Introduce kcti1', // 첫 번째 버튼의 메시지
                  ),
                  ImageButtonItem(
                    imagePath: 'assets/images/flower.png',
                    borderRadius: 38.0,
                    width: 180,
                    height: 250,
                    message: 'Flower: Introduce kcti2', // 두 번째 버튼의 메시지
                  ),
                  ImageButtonItem(
                    imagePath: 'assets/images/desk.png',
                    borderRadius: 38.0,
                    width: 180,
                    height: 250,
                    message: 'Desk: music Introduce kcti3', // 세 번째 버튼의 메시지
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Center(child: Text('Chair: Introduce kcit1')),
                    ),
                    Expanded(
                      child: Center(child: Text('Flower: Introduce kcti2')),
                    ),
                    Expanded(
                      child: Center(child: Text('Desk: music video kcti3')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageButtonItem extends StatelessWidget {
  final String imagePath;
  final double borderRadius;
  final double width;
  final double height;
  final String message; // 버튼을 눌렀을 때 전송할 메시지

  const ImageButtonItem({
    required this.imagePath,
    this.borderRadius = 8.0,
    required this.width,
    required this.height,
    required this.message,
    Key? key,
  }) : super(key: key);

  void sendMessageToUnity(String message) async {
    String serverIp = '10.0.2.2';
    int serverPort = 12345;

    try {
      Socket socket = await Socket.connect(serverIp, serverPort);
      print('Connected to Unity at $serverIp:$serverPort');

      // 송신
      socket.write(message);
      print('Sent: $message');

      // 수신
      socket.listen((List<int> event) {
        String receivedMessage = utf8.decode(event);
        print('Received: $receivedMessage');
        socket.destroy();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 이미지를 탭했을 때 메시지 전송
        print(message);
        sendMessageToUnity(message);
      },
      splashColor: Colors.red,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
