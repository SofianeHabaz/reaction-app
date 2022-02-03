import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reaction_speed/screens/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    //bool isKeyboard = MediaQuery.of(context).viewInsets.bottom !=0;
    return Scaffold(
      backgroundColor: Colors.white,//const Color(0xFF2A2A2A),
      body: const Login(),
      /*floatingActionButton: !isKeyboard ? const FloatingActionButton.extended(
        onPressed: null, 
        label: Icon(Icons.arrow_right_alt_rounded, size: 60.0,),
        backgroundColor: Colors.purple,
        
        ) : null,*/

    );
  }
}

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {    
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height*0.1),
                child: Image.asset('assets/mc_logo.png',),
              ),
              const SizedBox(height: 50.0,),
              LoginFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFields extends StatefulWidget {
  const LoginFields({ Key? key }) : super(key: key);

  @override
  _LoginFieldsState createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  // ignore: prefer_final_fields
  var _controller1 = TextEditingController();
  // ignore: prefer_final_fields
  var _controller2 = TextEditingController();
  int i=1;
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedCrossFade(
          firstChild: NameLogin(controller1: _controller1), 
          secondChild: AgeLogin(controller2: _controller2), 
          duration: Duration(milliseconds: 500),
          crossFadeState: i==1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
        SizedBox(height: 200,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              i==2 ? 
              Container(
                height: 50.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), 
                  color: Colors.purple,
                ),
                child: Center(
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        i--;
                      });
                    },
                  ),
                ),
              ) 
              : SizedBox(height: 0.0,),
              Container(
                height: 50.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), 
                  color: Colors.purple,
                ),
                child: Center(
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: 30.0,
                    ),
                    onPressed: ()async {      
                      if(i==1 && _controller1.text.isEmpty) return;                             
                      if(i==2){
                        if(_controller2.text.isEmpty) return;
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString("name", _controller1.text);
                        await prefs.setInt("age", int.parse(_controller2.text));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Intro(name: _controller1.text,age: int.parse(_controller2.text),)));
                      }
                      else {
                        setState(() {
                          i++;
                        });                          
                      }                      
                    }, 
                  ),
                ),
              ),
            ]
          ),
        ),
      ],
    );
    
  }
}

class NameLogin extends StatefulWidget {
  const NameLogin({
    Key? key,
    required TextEditingController controller1,
  }) : _controller1 = controller1, super(key: key);

  final TextEditingController _controller1;

  @override
  State<NameLogin> createState() => _NameLoginState();
}

class _NameLoginState extends State<NameLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Enter your name!', style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
        Container(
          padding: EdgeInsets.only(left: 20.0),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: TextField(            
              decoration: const InputDecoration(
                counterText: "",
                fillColor: Colors.black,
                hintText: "Name...",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,              
              ),
              maxLength: 20,
              controller: widget._controller1,
            ),
          ),
      ],
    );
  }
}

class AgeLogin extends StatefulWidget {
  const AgeLogin({
    Key? key,
    required TextEditingController controller2,
  }) : _controller2 = controller2, super(key: key);

  final TextEditingController _controller2;

  @override
  State<AgeLogin> createState() => _AgeLoginState();
}

class _AgeLoginState extends State<AgeLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          Text('Enter your age!', style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),),
          Container(
          padding: EdgeInsets.only(left: 20.0),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: TextField(            
              decoration: const InputDecoration(
                counterText: "",
                fillColor: Colors.black,
                hintText: "Age...",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                     
              ),
              maxLength: 2,
              keyboardType: TextInputType.number,
              controller: widget._controller2,
            ),
        ),
      ],
    );
  }
}