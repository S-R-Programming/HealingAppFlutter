import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicActivity extends StatelessWidget {
  MusicActivity({Key? key, required this.title_text,required this.composer_text,required this.image_path, required this.music_path}) : super(key: key);

  final String title_text;
  final String composer_text;
  final String image_path;
  final String music_path;
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 140,),
              Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage( image: AssetImage(image_path))
                  )
              ),
              SizedBox(height: 100,),
              Text(
                  title_text,
                  style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    color: Colors.white
                  )
              ),
              Text(
                  composer_text,
                  style: GoogleFonts.notoSansJavanese(
                      textStyle: TextStyle(fontSize: 15),
                      color: Colors.white
                  )
              ),
              SizedBox(height: 10,),
              btnStart(context),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),

    );
  }

  Widget btnStart(BuildContext context){
    AudioCache audioCache = AudioCache(fixedPlayer: audioPlayer);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: isPlaying==false?Icon(Icons.play_arrow,color:Colors.white,size: 60,):Icon(Icons.stop,color:Colors.white,size: 60,),
          onPressed:() async {
            if(isPlaying==false){
              print("アイコン再生");
              print("isPlaying  "+isPlaying.toString());
              audioCache.play(music_path);
              isPlaying=true;
              print("isPlaying  "+isPlaying.toString());
              (context as Element).markNeedsBuild();//これでsetStateみたいなことが出来る
            }
            else if(isPlaying==true){
              print("アイコン止める");
              AudioPlayer audioSource = await audioCache.loop(music_path);
              audioSource.pause();
              isPlaying=false;
              (context as Element).markNeedsBuild();//これでsetStateみたいなことが出来る
            }
          } ,
        ),
        SizedBox(width: 40,)//汚いがアイコンの中心座標がアイコンの端にあるので、仕方ない
      ],
    );
  }

}