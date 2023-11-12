import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AiPrompt extends StatefulWidget {
  const AiPrompt({Key? key}) : super(key: key);

  @override
  _AiPromptState createState() => _AiPromptState();
}

class _AiPromptState extends State<AiPrompt> {


  void sendDataToUnity(BuildContext context) async {
    try {
      Socket socket = await Socket.connect('192.168.68.52', 1234);
      socket.write('HI Hello');
      socket.destroy();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('연결 실패'),
            content: Text('연결이 실패했습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  String negative_prompts =
      "nipples, nude, nsfw, (missing legs:1.8), (ng_deepnegative_v1_75t:1.5), "
      "(badhandv4:1.6), (bad hands), ((weird legs:1)), ((duplicate legs:1)), ((weird fingers)), "
      "((bad thigh)), ((extra fingers)), ((short legs)), ((extra legs)), ((duplicate fingers)), "
      "((extra fingers)), (low quality:2), (normal quality:2), (worst quality:2), "
      "low-res, ((monochrome)), ((grayscale)), "
      "((wrong feet)),(wrong shoes), distorted, (badhandv4:1.7),";

  bool checkBoxValueA = false;
  bool checkBoxValueB = false;
  bool checkBoxValueC = false;
  bool checkBoxValueD = false;
  bool checkBoxValueE = false;
  bool checkBoxValueF = false;
  bool checkBoxValueG = false;
  bool checkBoxValueH = false;
  bool checkBoxValueI = false;
  bool checkBoxValueJ = false;
  bool checkBoxValueK = false;
  bool checkBoxValueL = false;
  bool checkBoxValueM = false;
  bool _isButtonDisabled = false;

  final String url = "http://10.0.2.2:7860";
  //final String url = "http://192.168.68.52:7860";
  final _textController = TextEditingController();

  Column checktile() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SingleChildScrollView(
        child: CheckboxListTile(
            title: const Text('자연풍경',
                style: TextStyle(fontSize: 22, color: Colors.white)),
            value: checkBoxValueA,
            onChanged: (value) {
              setState(() {
                checkBoxValueA = value!;
                if (value) {
                  _textController.text += ' 자연풍경,';
                }
              });
            }),
      ),
      CheckboxListTile(
          title: const Text('인물중심',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueB,
          onChanged: (value) {
            setState(() {
              checkBoxValueB = value!;
              if (value) {
                _textController.text += ' 인물중심,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('도시배경',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueC,
          onChanged: (value) {
            setState(() {
              checkBoxValueC = value!;
              if (value) {
                _textController.text += ' 도시배경,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('자연배경',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueD,
          onChanged: (value) {
            setState(() {
              checkBoxValueD = value!;
              if (value) {
                _textController.text += ' 자연배경,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('카메라뷰전체',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueE,
          onChanged: (value) {
            setState(() {
              checkBoxValueE = value!;
              if (value) {
                _textController.text += ' 카메라뷰전체,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('카메라뷰일부',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueF,
          onChanged: (value) {
            setState(() {
              checkBoxValueF = value!;
              if (value) {
                _textController.text += ' 카메라뷰일부,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('패션',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueG,
          onChanged: (value) {
            setState(() {
              checkBoxValueG = value!;
              if (value) {
                _textController.text += ' 패션,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('인테리어',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueH,
          onChanged: (value) {
            setState(() {
              checkBoxValueH = value!;
              if (value) {
                _textController.text += ' 인테리어,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('만화',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueI,
          onChanged: (value) {
            setState(() {
              checkBoxValueI = value!;
              if (value) {
                _textController.text += ' 만화,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('판타지',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueJ,
          onChanged: (value) {
            setState(() {
              checkBoxValueJ = value!;
              if (value) {
                _textController.text += ' 판타지,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('K-POP아이돌',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueK,
          onChanged: (value) {
            setState(() {
              checkBoxValueK = value!;
              if (value) {
                _textController.text += ' K-POP아이돌,';
              }
            });
          }),
      CheckboxListTile(
          title: const Text('기계',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          value: checkBoxValueL,
          onChanged: (value) {
            setState(() {
              checkBoxValueL = value!;
              if (value) {
                _textController.text += ' 기계,';
              }
            });
          }),
      CheckboxListTile(
        title: const Text('에스에프장르',
            style: TextStyle(fontSize: 22, color: Colors.white)),
        value: checkBoxValueM,
        onChanged: (value) {
          setState(() {
            checkBoxValueM = value!;
            if (value) {
              _textController.text += ' 에스에프장르,';
            }
          });
        },
        checkColor: Colors.white,
        activeColor: Colors.green,
      ),
    ]);
  }
  void checkboxReset() {
    checkBoxValueA = false;
    checkBoxValueB = false;
    checkBoxValueC = false;
    checkBoxValueD = false;
    checkBoxValueE = false;
    checkBoxValueF = false;
    checkBoxValueG = false;
    checkBoxValueH = false;
    checkBoxValueI = false;
    checkBoxValueJ = false;
    checkBoxValueK = false;
    checkBoxValueL = false;
    checkBoxValueM = false;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0C312F),
      body: Row(children: <Widget>[
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "<Select AI Contol Topic>",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.lime),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  // Wrap the content in SingleChildScrollView
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: checktile(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 5.0),
                  ),
                  labelText: 'Enter Prompt here'),
              style: TextStyle(fontSize: 22, color: Colors.white),
              cursorColor: Colors.cyan,
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Container(
                  width: 70,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        _textController.text = '';
                        checkboxReset();
                        setState(() {});
                      },
                      child: Text(
                        'Prompt clear',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),

                Container(
                  width: 70,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: _isButtonDisabled
                          ? null
                          : () async {
                              setState(() {
                                _isButtonDisabled = true;
                              });
                              String prompt = _textController.text;
                              _textController.text = '';
                              prompt = GenPrompt(prompt);
                              Map<String, dynamic> payload = DetailOption(prompt);
                              try {
                                http.Response response = await http.post(
                                  Uri.parse('$url/sdapi/v1/txt2img'),
                                  headers: {
                                    'Content-Type':
                                        'application/json; charset=UTF-8'
                                  },
                                  body: jsonEncode(payload),
                                );
                                // 콘솔로 명령확인
                                String respondstring =
                                    jsonDecode(response.body)['meta']['prompt']
                                        .cast<String>();
                                print(respondstring);
                              } catch (error) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          content: Text("서버에 접속이 안되어있습니다"),
                                          actionsPadding: EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 30),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                        TextButton(
                                            onPressed: () {}, child: Text('확인'))
                                      ]),
                                );
                                await Future.delayed(Duration(seconds: 1));
                                Navigator.pop(context);
                              } finally {
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              }
                            },
                      child: Text(
                        '전송',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),

                Container(
                  width: 90,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        _textController.text = '';
                        checkboxReset();
                        setState(() {});
                        sendDataToUnity(context);
                      },
                      child: Text(
                        'Unity call',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                ),


              ],
            )
          ]),
        )),
      ]),
    );
  }

  String GenPrompt(String prompt) {

    if (prompt.contains("자연풍경")) {
      prompt = prompt.replaceAll(
          "자연풍경",
          "ancient chinese style landscape painting,"
              " mountains in front, beautiful winding green river behind, "
              "extremely sharp old paper detail, high paper detail,"
              " high line detail, high resolution, ultra high quality,");
    }
    if (prompt.contains("인물중심")) {
      prompt = prompt.replaceAll(
          "인물중심",
          "1girl, best quality, high quality,  masterpiece, beautiful face,"
              "looking at viewer, sunset sky, cinematic light,");
    }
    if (prompt.contains("도시배경")) {
      prompt = prompt.replaceAll(
          "도시배경",
          "Extremely detailed scene,Downtown Minneapolis, city ,"
              "sun rays, summertime, somewhat cloudy, day time,detailed cinematic,"
              "realistic photographic");
    }
    if (prompt.contains("자연배경")) {
      prompt = prompt.replaceAll("자연배경",
          "high quality, mountain, sunset sky, waterfall,");
    }
    if (prompt.contains("카메라뷰전체")) {
      prompt = prompt.replaceAll(
          "카메라뷰전체", "perspective camera, wide view,");
    }
    if (prompt.contains("카메라뷰일부")) {
      prompt =
          prompt.replaceAll("카메라뷰일부", "cowboy shot,");
    }
    if (prompt.contains("패션")) {
      prompt = prompt.replaceAll("패션",
          "shiny floral elegance dress, shiny shoes,");
    }
    if (prompt.contains("인테리어")) {
      prompt = prompt.replaceAll(
          "인테리어",
          "best quality,realistic,living room,"
              "Modern minimalist Nordic style,"
              "Soft light,Pure picture,Symmetrical composition, cinematic light,");
    }
    if (prompt.contains("만화")) {
      prompt = prompt.replaceAll(
          "만화", "cartoon style, manga, ");
    }
    if (prompt.contains("판타지")) {
      prompt = prompt.replaceAll(
          "판타지", "fantasy, cartoon fantasy, ");
    }
    if (prompt.contains("K-POP아이돌")) {
      prompt = prompt.replaceAll(
          "K-POP아이돌",
          "1girl, best quality, high quality,  masterpiece, beautiful face,"
              "looking at viewer, sunset sky, cinematic light, ");
    }
    if (prompt.contains("기계")) {
      prompt =
          prompt.replaceAll("기계", "machine, robot,");
    }
    if (prompt.contains("에스에프장르")) {
      prompt = prompt.replaceAll("에스에프장르",
          "sci-fi, cyber func, lazer lights, robot,");
    }

    return prompt;
  }

  Map<String, dynamic> DetailOption(String prompt) {
                       Map<String, dynamic> payload = {
      "prompt": prompt,
      "width" : 512,
      "height": 768,
      "steps": 50,
      "cfg_scale": 7,
      "hr_scale": 2,
      "negative_prompt": negative_prompts,
      "send_images": true,
      "save_images": true,
      "alwayson_scripts": {}
    };
    return payload;
  }

}
