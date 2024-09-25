import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'home_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1450), () {}); // Increase delay to match animation duration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
      Center(
        child: 
        AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            ScaleAnimatedText(
              'fynd',
              textStyle: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white,),
            ),
          ],
          onFinished: () {
          },
        ),
      ),
    );
  }
}
