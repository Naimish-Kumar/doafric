import 'package:doafric/home_screen.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class Bottom extends StatefulWidget {
  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  final tabs = [
    const HomeScreen(),
    const Categories(),
    const Center(child: Text('Cart page')),
    const Center(child: Text('Account page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.horizontal_split_sharp),
                label: 'Categories',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart_outlined),
                label: 'Cart',
                 backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Account',
                backgroundColor: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
