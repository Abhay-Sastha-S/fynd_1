import 'package:flutter/material.dart';
// import 'package:fashiontinder3/pages/cart_page.dart';
import '../pages/home_page.dart';
// import 'package:fashiontinder3/pages/moodboard_page.dart';
// import 'package:fashiontinder3/pages/explore_page.dart';
// import 'package:fashiontinder3/pages/profile_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => _onItemTapped(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.explore,
                  color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                ),
                
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _onItemTapped(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                ),
                
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _onItemTapped(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                ),
                
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _onItemTapped(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: _currentIndex == 3 ? Colors.blue : Colors.grey,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _onItemTapped(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: _currentIndex == 4 ? Colors.blue : Colors.grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



        // type: BottomNavigationType.fixed,
        // items: [
        //   BottomNavigationItem(icon: Icon(Icons.explore), label: ''),
        //   BottomNavigationItem(icon: Icon(Icons.shopping_cart), label: ''),
        //   BottomNavigationItem(icon: Icon(Icons.home), label: ''),
        //   BottomNavigationItem(icon: Icon(Icons.favorite), label: ''),
        //   BottomNavigationItem(icon: Icon(Icons.person), label: ''),
        // ],
      