import 'package:flutter/material.dart';
import 'package:jdds/auth.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState(){
    super.initState();
    _navigateauth();
  }
  _navigateauth() async{
      await Future.delayed(Duration(milliseconds: 2500),(){});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Auths()));
  }

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 3000)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Navigation logic here
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auths()));
        }

        return Container(
          color: Colors.black,
          child: Center(
            child: Image.asset(
              "assets/TODO-2.png",
            ),
          ),
        );
      },
    );
  }
}