import 'package:flutter/material.dart';
import 'package:galtap7/pages/ImagePanel.dart';
import 'package:galtap7/pages/aiprompt.dart';
import 'package:galtap7/pages/magicline.dart';
import 'package:galtap7/pages/music.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TapMenu().length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> TapMenu() {
    return [
      const Center(child: AiPrompt()),
      const Center(child: ImagePanel()),
      const Center(child: Magicline()),
      const Center(child: MusicHomePage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AI Media Control Mobile v1.0",
              style: TextStyle(color: Colors.cyan)),
          backgroundColor: Colors.transparent,
        ),
        //backgroundColor: Color(0xff0C312F),
        backgroundColor: Colors.black12,
        body: Stack(children: [
          Column(children: <Widget>[
            TabBar(controller: _tabController,
                /////
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    color: Color(0xff0C312F)),
                labelColor: Colors.white,
                unselectedLabelColor: Color(0xff11796D),
                /////
                tabs: <Widget>[
              Tab(
                  icon: Image.asset('assets/images/aiw.png',
                      width: 33, height: 33),
                  text: 'AI CONTOL'),
              Tab(
                  icon: Image.asset('assets/images/picturew.png',
                      width: 33, height: 33),
                  text: 'RENDERING'),
              Tab(
                  icon: Image.asset('assets/images/magicw.png',
                      width: 33, height: 33),
                  text: 'MASIC LINE'),
              Tab(
                  icon: Image.asset('assets/images/musicw.png',
                      width: 33, height: 33),
                  text: 'MUSIC'),
            ]
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: TapMenu(),
            ))
          ]),
        ]));
  }
}
