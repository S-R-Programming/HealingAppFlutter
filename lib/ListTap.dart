import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTap extends StatelessWidget {
  const ListTap({Key? key, required this.image_path, required this.title_text, required this.content_text}) : super(key: key);


  final String title_text;
  final String image_path;
  final String content_text;

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
              SizedBox(height: 40,),
              Container(
                  decoration: BoxDecoration(
                    //背景色
                    color: Colors.white,
                    // 枠線
                    border: Border.all(color: Colors.blue, width: 2),
                    // 角丸
                    borderRadius: BorderRadius.circular(8),
                  ),
                width: 350,
                  padding: EdgeInsets.all(8),
                 // color: Colors.white,
                  child: Text(title_text,
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 22),
                    ),),
              ),
              SizedBox(height: 10,),
              Container(
                height: 550,
                  decoration: BoxDecoration(
                    //背景色
                    color: Colors.white,
                    // 枠線
                    border: Border.all(color: Colors.blue, width: 2),
                    // 角丸
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage( image: AssetImage(image_path))
                          )
                      ),
                      SizedBox(height: 30,),
                      Text(content_text,style: TextStyle(fontSize: 20),),

                    ],
                  ),

                width: 350,
                padding: EdgeInsets.all(8),
              ),

            ],
          ),
        ),
      ),

    );
  }
}