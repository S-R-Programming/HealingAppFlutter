import 'package:flutter/material.dart'; //google提供のUIデザイン
import 'dart:async'; //非同期処理用
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'ListTap.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => BottomNavigationSetstate();
}

//タブ部分
class BottomNavigationSetstate extends State<MyHomePage> {
  int _currentIndex = 0;

  final _childPageList = [
    _ChildPage1(),
    _ChildPage2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _childPageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Spots'),
            icon: Icon(Icons.location_pin),
          ),
          BottomNavigationBarItem(
            title: Text('Music'),
            icon: Icon(Icons.music_note),
          )
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


class _ChildPage1 extends StatefulWidget {
  _ChildPage1({Key? key}) : super(key: key);

  @override
  _ChildPage1State createState() => _ChildPage1State();
}

//新着
class _ChildPage1State extends State<_ChildPage1> {

  List Spots=[];

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/healing_spot.json").then((s){
      setState(() {
        print("データ読み込み");
        Spots=json.decode(s);
      });
    });
  }



  @override
  void initState() {
    super.initState();
    ReadData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage( image: AssetImage("images/mizutama.jpg"),
              fit: BoxFit.cover,
              ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    //背景色
                    color: Colors.white,
                    // 枠線
                    border: Border.all(color: Colors.red, width: 2),
                    // 角丸
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("おすすめ癒しスポットをご紹介！",
                      style: GoogleFonts.mochiyPopOne(
                      textStyle: TextStyle(fontSize: 20),
          ),),
                ),
                SizedBox(height: 3,),
                SizedBox(
                  height: 580,
                  width: 350,
                  child: ListView.builder( //スクロール可能な可変リストを作る
                      itemCount: Spots == null ? 0 : Spots.length, //受け取る数の定義
                      itemBuilder: (BuildContext context, int index)
                      { //ここに表示したい内容をindexに応じて
                        return GestureDetector(
                          onTap: (){
                            //リストをタップしたとき
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return ListTap(image_path: Spots[index]["img"], title_text: Spots[index]["title"], content_text: Spots[index]["content"],);//引数を渡せば画面遷移先で画像を表示出来る
                                  }),
                            );
                          },
                          child: SizedBox(
                            height: 100,
                            child: Card(//cardデザインを定義:material_design
                                child: Row(
                                    children: <Widget>[
                                      SizedBox(width: 10,),//カード左端の余白
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Spots[index]["title"],
                                              style: TextStyle(
                                                  fontSize: 15
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),


                                      Container(
                                        width: 100,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage( image: AssetImage(Spots[index]["img"]))
                                            )
                                        ),
                                      SizedBox(width: 5,)



                                    ]
                                )
                            ),
                          ),
                        );
                      }
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}

class _ChildPage2 extends StatefulWidget {
  _ChildPage2({Key? key}) : super(key: key);

  @override
  _ChildPage2State createState() => _ChildPage2State();
}

class _ChildPage2State extends State<_ChildPage2> {
  List Music=[];
  List MusicTile=[];

  ReadDataTop() async {
    await DefaultAssetBundle.of(context).loadString("json/healing_music.json").then((s){
      setState(() {
        print("データ読み込みTop");
        Music=json.decode(s);
      });
    });
  }

  ReadDataTile() async {
    await DefaultAssetBundle.of(context).loadString("json/healing_music_tile.json").then((s){
      setState(() {
        print("データ読み込みTile");
        MusicTile=json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ReadDataTop();
    ReadDataTile();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Column(
        children: [
          SizedBox(height: 40,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Healing Music",
                style: GoogleFonts.italiana(
                  textStyle: TextStyle(fontSize: 40),
                ),),
            ],
          ),
          SizedBox(height: 20,),
          Container(
              height: 150,
              width: 300,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: Music==null?0:Music.length,
                itemBuilder: (_,i){
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(Music[i]["img"]))//「images/flower_one.png」など
                    ),

                  );
                },

              )
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 420,
            width: 350,
            child: ListView.builder( //スクロール可能な可変リストを作る
                itemCount: MusicTile == null ? 0 : MusicTile.length, //受け取る数の定義
                itemBuilder: (BuildContext context, int index)
                { //ここに表示したい内容をindexに応じて
                  return GestureDetector(
                    onTap: (){
                      //リストをタップしたとき
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context){
                              return ListTap(image_path: MusicTile[index]["img"], title_text: MusicTile[index]["title"], content_text: MusicTile[index]["composer"],);//引数を渡せば画面遷移先で画像を表示出来る
                            }),
                      );
                    },
                    child: SizedBox(
                      height: 100,
                      child: Card(//cardデザインを定義:material_design
                          child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),//カード左端の余白
                                Container(
                                    width: 100,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage( image: AssetImage(MusicTile[index]["img"]))
                                    )
                                ),
                                SizedBox(width: 20,),
                               SizedBox(
                                 width: 200,
                                 child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15,),
                                        Text(
                                          MusicTile[index]["title"],
                                          style: GoogleFonts.notoMusic(
                                            textStyle: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        //SizedBox(height: 5,),
                                        Text(
                                          MusicTile[index]["composer"],
                                          style: GoogleFonts.notoMusic(
                                            color: Colors.grey,
                                            textStyle: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                               ),

                              ]
                          )
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),

    );
  }

}


