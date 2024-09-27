import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import '../providers/product_service.dart';
import '../providers/data_provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ProductService.initHive();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.loadProducts(); // Start loading products in the background
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1800), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          animatedTexts: [
            ScaleAnimatedText(
              'fynd',
              textStyle: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white,),
            ),
          ],
          onFinished: () {},
        ),
      ),
    );
  }
}