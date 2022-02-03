import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reaction_speed/screens/multiplayer/multi_mode_settings.dart';
import 'package:reaction_speed/screens/solo/solo_mode.dart';
class GameSetting extends StatefulWidget {
  const GameSetting({ Key? key }) : super(key: key);

  @override
  _GameSettingState createState() => _GameSettingState();
}

class _GameSettingState extends State<GameSetting> {
  int i=1;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Select game mode !", style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w400,),),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SoloMode()));
              },
              child: Container(
                height: 50.0,
                width: size.width*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.purple,
                ),
                child:Center(
                  child: Text("Solo", style: GoogleFonts.ubuntu(color: Colors.white,fontSize: 30.0),),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MultiModeSettings()));
              },
              child: Container(
                height: 50.0,
                width: size.width*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.purple,
                ),
                child:Center(
                  child: Text("Multiplayer", style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 30.0),),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
