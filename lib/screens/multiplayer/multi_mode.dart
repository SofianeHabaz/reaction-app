import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiMode extends StatefulWidget {
  final int nbPlayer;
  const MultiMode({ Key? key, required this.nbPlayer }) : super(key: key);

  @override
  _MultiModeState createState() => _MultiModeState();
}

class _MultiModeState extends State<MultiMode> {

  int index=1;
  late Stopwatch stopWatch;
  late Timer t;
  List<Map<String, String>> scores = [];
  int i = 1;
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
    int nbPlayer = widget.nbPlayer;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: index<nbPlayer+1 && i==4 
      ? FloatingActionButton.extended(
        onPressed: (){
          setState(() {   
            scores.add({"Player $index": formatedTime()});
            scores.sort((a,b)=>a.entries.first.value.compareTo(b.entries.first.value)); 
            i=1;
            index++;            
            stopWatch.reset();                                        
          });
        }, 
        label: Text(index==nbPlayer ? "Scores" : "Next Player"), 
        backgroundColor: Colors.purple,
      )
      : index==nbPlayer+1 ? FloatingActionButton.extended(
        onPressed: (){
          setState(() {    
            scores.clear();
            index=1;
            i=1;
            stopWatch.reset();                                        
          });
        }, 
        label: Text("Replay"), 
        backgroundColor: Colors.purple,
      ) : null,
      floatingActionButtonLocation: index==nbPlayer+1 ? FloatingActionButtonLocation.centerFloat : null,
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
      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: index==nbPlayer+1 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        secondChild: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: scores.length,
            itemBuilder: (context, index){
              return Padding(
                padding: index==scores.length-1 
                ? EdgeInsets.only(top: 10,left: 20.0, right:20.0, bottom: 100.0) 
                : EdgeInsets.symmetric(horizontal: 20.0, vertical:10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(scores[index].entries.first.key, style: GoogleFonts.ubuntu(color: Colors.purple, fontWeight: FontWeight.w500, fontSize: 22.0),),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Text("Score: ", style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20.0),),
                            Text(scores[index].entries.first.value, style: GoogleFonts.ubuntu(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20.0),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        firstChild: Padding(
          padding: EdgeInsets.only(top: size.height*0.1, bottom: size.height*0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(index==nbPlayer+1 ? "Player ${index-1} turn!" : "Player $index turn!", style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
                
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
                i!=4 ? SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: i==1 ? Colors.green: Colors.red,
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
                        i== 1 ? Icon(Icons.play_arrow) : Icon(Icons.stop),
                        Text(i==1 ? "Start" : "Stop"),
                      ],
                    ) 
                  ),
                ):SizedBox(height: 0.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}