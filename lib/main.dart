import 'package:flutter/material.dart'; //google提供のUIデザイン
import 'dart:async'; //非同期処理用
import 'dart:convert';


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
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Child Page1'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Child Page2'),
            icon: Icon(Icons.person),
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
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("おすすめ癒しスポットをご紹介！"),
              SizedBox(height: 50,),
              SizedBox(
                height: 550,
                width: 350,
                child: ListView.builder( //スクロール可能な可変リストを作る
                    itemCount: Spots == null ? 0 : Spots.length, //受け取る数の定義
                    itemBuilder: (BuildContext context, int index)
                    { //ここに表示したい内容をindexに応じて
                      return SizedBox(
                        height: 100,
                        child: Card(//cardデザインを定義:material_design
                            child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),

                                  Flexible(
                                    child: Column(
                                      children: [
                                        Text(
                                          Spots[index]["title"],
                                          style: TextStyle(
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),


                                  Container(
                                    width: 90,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage( image: AssetImage(Spots[index]["img"]))
                                        )
                                    ),



                                ]
                            )
                        ),
                      );
                    }
                ),
              ),

            ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

}


