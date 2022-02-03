import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reaction_speed/screens/game_setting.dart';

class Intro extends StatefulWidget {
  final String name;
  final int age;
  const Intro({Key? key, required this.name, required this.age}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  
  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    int age = widget.age;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GameSetting()));
        }, 
        label: Text("Play"), 
        icon: Icon(Icons.play_arrow), 
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey $name,",style: GoogleFonts.oswald(color: Colors.purple,fontSize: 40.0, fontWeight: FontWeight.bold),),
              Text("so you have $age yo 🎉",style: GoogleFonts.oswald(fontSize: 30.0, fontWeight: FontWeight.w500),),
              SizedBox(height: 50.0,),
              Center(child: Image.asset("assets/speed_image.png", scale: 0.8,)),
              SizedBox(height: 20.0,),
              Center(child: Text("Lets test your reaction speed!",style: GoogleFonts.oswald(color: Colors.black,fontSize: 30.0,), textAlign: TextAlign.center,)),
                           
            ]
          ),
        ),
      ),
    );
  }
}