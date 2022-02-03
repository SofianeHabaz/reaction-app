import 'package:flutter/material.dart';
import 'package:reaction_speed/screens/intro.dart';
import 'package:reaction_speed/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String name;
  late int age;
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
    setNameAndAge();
  }
  Future setNameAndAge() async {
    setState(() {
      isLoading=true;
    });
    name = await getName();
    age = await getAge();
    setState(() {
      isLoading=false;
    });
  }
  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString("name");
    if(name == null) return "";
    return name;
  }

  Future<int> getAge() async {
    final prefs = await SharedPreferences.getInstance();
    final age = prefs.getInt("age");
    if(age == null) return 0;
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reaction Speed',
      home: isLoading ? CircularProgressIndicator() : name=="" && age==0 ? LoginPage(title: 'Reaction Speed') : Intro(name: name, age: age),
      debugShowCheckedModeBanner: false,
    );
  }
}

