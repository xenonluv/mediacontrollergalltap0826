import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RenderPage extends StatefulWidget {
  const RenderPage({Key? key}) : super(key: key);

  @override
  _RenderPageState createState() => _RenderPageState();
}
class _RenderPageState extends State<RenderPage> {
  String ipAddress = "10.0.2.2:7860";
  String jobTimestamp = '';
  List<int>? imageBytes;
  late var base64Image;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => refreshImage());
  }

  Future<void> refreshImage() async {
    final url = Uri.parse('http://$ipAddress/sdapi/v1/progress?skip_current_image=false');
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      base64Image = data['current_image'];
      jobTimestamp  = data['state']['job_timestamp'];

      if (base64Image != '') {
        setState(() { // Update the state when the image changes.
          imageBytes = base64Decode(base64Image);
        });
      } else {
        print('current_image의 값이 없습니다. 다시 불러와지길 기다립니다...');
      }

    //  Timer.periodic(Duration(seconds: 1), (Timer t) => getImageFinalServer() );
      getImageFinalServer();
    } else {
      print('서버에서 이미지를 불러오는 데 실패했습니다.');
    }

  }

  Future<void> getImageFinalServer() async {

    final url = Uri.parse('http://$ipAddress/file=outputs/txt2img-images/$jobTimestamp.png');
    final response = await http.get(url);
    if (response.statusCode ==200){
      setState((){ // Update the state with the final image.
        imageBytes=response.bodyBytes;
      });
      print("서버에서 최종 이미지를 성공적으로 불러왔습니다.");
      timer?.cancel();

    } else{
      print("서버에서 최종 이미지를 불러오는데 실패했습니다.");
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("이미지 업데이트")),
      body : Center(
          child : imageBytes !=null ?
          Image.memory(Uint8List.fromList(imageBytes!))
              : CircularProgressIndicator()
      ),
    );
  }
}
