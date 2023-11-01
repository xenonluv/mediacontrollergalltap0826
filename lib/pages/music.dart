import 'package:flutter/material.dart';

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  final String title = "MUSIC";

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {

  void _onTapTrack() {
    // Code to handle tap event on a track...
    print('Track tapped!');
  }

  // Define rainbow colors
  final List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(itemCount :20,itemBuilder:(context,index){
                    return ListTile(title : Text("Track $index"), onTap:_onTapTrack);
                  }),
                ),
                Expanded(
                  child: ListView.builder(itemCount :20,itemBuilder:(context,index){
                    return ListTile(title : Text("Additional List Item $index"));
                  }),
                )
              ],
            ),
          ),
          SizedBox(height:5,),
          Container(height: MediaQuery.of(context).size.height * .1,
              child:
              ListView.builder(scrollDirection: Axis.horizontal, itemCount :8,itemBuilder:(context,index){
                return Padding(padding:
                EdgeInsets.all(10.0),child:
                ElevatedButton(onPressed: (){}, child:
                Text("Button $index"),
                    style:ElevatedButton.styleFrom(primary :rainbowColors[index % rainbowColors.length])
                )
                );
              }
              )
          ),
          Container(height: MediaQuery.of(context).size.height * .3,
            child:
            Row(children:[
              Expanded(child:
              Container(height: MediaQuery.of(context).size.height * .3,
                  child:
                  ListView.builder(scrollDirection: Axis.vertical, itemCount :10,itemBuilder:(context,index){
                    return ListTile(title : Text("Row List Item $index"));
                  })
              ),
              ),
              Expanded(child:
              Container(height: MediaQuery.of(context).size.height * .3,
                  child:
                  ListView.builder(scrollDirection: Axis.vertical, itemCount :10,itemBuilder:(context,index){
                    return ListTile(title : Text("Row Additional List Item $index"));
                  })
              ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
