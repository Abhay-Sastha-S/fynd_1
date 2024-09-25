import 'package:flutter/material.dart';
import 'package:fynd_1/pages/explore_page.dart';
import 'package:fynd_1/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'pages/landing_page.dart';
import 'providers/data_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fynd',
      home: LandingPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/explore': (context) => ExplorePage(),
        },
    );
  }
}
