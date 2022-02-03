import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloMode extends StatefulWidget {
  const SoloMode({ Key? key }) : super(key: key);

  @override
  _SoloModeState createState() => _SoloModeState();
}

class _SoloModeState extends State<SoloMode> {
  int i=1;
  late Stopwatch stopWatch;
  late Timer t;

  String formatedTime(){
    var mili = stopWatch.elapsed.inMilliseconds;
    String miliseconds = (mili%1000).toString().padLeft(3,'0');
    String seconds = ((mili~/1000)%60).toString().padLeft(2,'0');
    String minutes = ((mili~/1000)~/60).toString().padLeft(2,'0');
    return "$minutes:$seconds:$miliseconds";
  }
  @override
  void initState() {
    super.initState();
    stopWatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if(mounted){
        setState(() {});
      }
      
     });
    
  }
  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        toolbarHeight: 60.0,
        title: Text("Reaction speed", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25.0),),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: size.height*0.1, bottom: size.height*0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: size.height*0.25,
                width: size.height*0.25,
                decoration: BoxDecoration(
                  color: i==1 ? Colors.grey[350] : i==2 ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                height: 60.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[300],
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Center(child: Text(formatedTime(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white))),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: i==1 ? Colors.green :  i==4 ? Colors.purple : Colors.red,
                  ),
                  onPressed: (){
                    if(i==1){
                      setState((){i=2;});
                      
                      Future.delayed(Duration(seconds: 3 + Random().nextInt(5)), (){
                        stopWatch.start();
                        setState((){i=3;});
                      });
                    }
                    else if(i==3){
                      stopWatch.stop();
                      setState((){i=4;});
                    }
                    else if(i==4)
                    {
                      stopWatch.reset();
                      setState(() {
                        i=1;
                      });
                    }
                  }, 
                  child: Row(
                    children: [
                      i== 1 ? Icon(Icons.play_arrow) : i==4 ? Icon(Icons.replay) : Icon(Icons.stop),
                      i==4 ? Text("Replay") : Text(i==1 ? "Start" : "Stop"),
                    ],
                  ) 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
