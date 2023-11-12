import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
class Magicline extends StatefulWidget {
  const Magicline({Key? key}) : super(key: key);

  @override
  State<Magicline> createState() => _MagiclineState();
}

class _MagiclineState extends State<Magicline> {

  void sendMessageToUnity(String message) async {
    // String serverIp = '192.168.68.52'; // Unity 서버 IP 주소
    String serverIp = '10.0.2.2';
    int serverPort = 12345; // Unity 서버 포트

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
        socket.destroy(); // 연결 종료
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Image Buttons Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('3D Image Buttons Example'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.yellow,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // First row of buttons
              Expanded(
                child: Row(
                  children: <Widget>[
                    ExpandedButton(imagePath: 'assets/images/button1.png', onPressed: () => sendMessageToUnity('play one')),
                    SizedBox(width: 10,),
                    ExpandedButton(imagePath: 'assets/images/button2.png', onPressed: () => sendMessageToUnity('play two')),
                  ],
                ),
              ),
              // Second row of buttons
              SizedBox(height: 20, width: 20,),
              Expanded(
                child: Row(
                  children: <Widget>[
                    ExpandedButton(imagePath: 'assets/images/button3.png', onPressed: () => sendMessageToUnity('play three')),
                    SizedBox(width: 10,),
                    ExpandedButton(imagePath: 'assets/images/button4.png', onPressed: () => sendMessageToUnity('play four')),
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

class ExpandedButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const ExpandedButton({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ExpandedButtonState createState() => _ExpandedButtonState();
}

class _ExpandedButtonState extends State<ExpandedButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onPressed,
        child: Transform.translate(
          offset: _isPressed ? Offset(0, 4) : Offset(0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: _isPressed
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ]
                  : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}