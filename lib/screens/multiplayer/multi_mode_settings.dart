import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reaction_speed/screens/multiplayer/multi_mode.dart';
import 'package:numberpicker/numberpicker.dart';

class MultiModeSettings extends StatefulWidget {
  const MultiModeSettings({ Key? key }) : super(key: key);

  @override
  _MultiModeSettingsState createState() => _MultiModeSettingsState();
}

class _MultiModeSettingsState extends State<MultiModeSettings> {
  int currentValue = 2;
  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MultiMode(nbPlayer: currentValue)));
        }, 
        label: Icon(Icons.arrow_right_alt_rounded),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose number of players!', style: GoogleFonts.ubuntu(color: Colors.purple, fontSize: 25.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ]
              ),
              child: Center(
                child: NumberPicker(
                  value: currentValue,
                  minValue: 2,
                  maxValue: 9,
                  onChanged: (value){
                    setState(() {
                      currentValue = value;
                    });
                  },
                  textStyle: TextStyle(color: Colors.grey, fontSize: 25.0, fontWeight: FontWeight.bold),
                  selectedTextStyle: TextStyle(color: Colors.purple, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
