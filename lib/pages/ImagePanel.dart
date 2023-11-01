import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ImageModel with ChangeNotifier {
  String _jobTimestamp = '';
  List<int>? _lastImage;
  String get jobTimestamp => _jobTimestamp;
  List<int>? get lastImage => _lastImage;

  void setJobTimestamp(String value) {
    _jobTimestamp = value;
    notifyListeners();
  }

  void setLastImage(List<int> value) {
    if (_lastImage != value) {
      _lastImage = value;
      notifyListeners();
    }
  }
}

class ImagePanel extends StatefulWidget {
  const ImagePanel({Key? key}) : super(key: key);

  @override
  _ImagePanelState createState() => _ImagePanelState();
}

class _ImagePanelState extends State<ImagePanel> {
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
    final url = Uri.parse(
        'http://$ipAddress/sdapi/v1/progress?skip_current_image=false');
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    });

    if (response.statusCode == HttpStatus.ok) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (data['current_image'] != null) {
        base64Image = data['current_image'];
      }

      Provider.of<ImageModel>(context, listen: false)
          .setJobTimestamp(data['state']['job_timestamp']);

      if (base64Image != null || base64Image != '') {
        var newImageBytes = base64Decode(base64Image);
        // Only update the state if the image bytes have actually changed.
        if (imageBytes != newImageBytes) {
          setState(() {
            getImageFinalServer();
            imageBytes = newImageBytes;
            Provider.of<ImageModel>(context, listen: false)
                .setLastImage(imageBytes!);
          });
        }
      } else {
        print('current_image의 값이 없습니다. 다시 불러와지길 기다립니다...');
        timer?.cancel();
      }
    } else {
      print('서버에서 이미지를 불러오는 데 실패했습니다.');
     // getImageFinalServer();
    }
  }

  Future<void> getImageFinalServer() async {
    final jobTimestamp =
        Provider.of<ImageModel>(context, listen: false).jobTimestamp;
    final url = Uri.parse(
        'http://$ipAddress/file=outputs/txt2img-images/$jobTimestamp.png');
    final response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      setState(() {
        imageBytes = response.bodyBytes;
      });
      print("서버에서 최종 이미지를 성공적으로 불러왔습니다.");
    } else {
      print("서버에서 최종 이미지를 불러오는데 실패했습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(title: Text("이미지 모니터링중"), backgroundColor: Colors.white10,),
      body: Center(

          child: Provider.of<ImageModel>(context).lastImage != null
              ? Image.memory(Uint8List.fromList(
                  Provider.of<ImageModel>(context).lastImage!))
              : CircularProgressIndicator()),
    );
  }
}
