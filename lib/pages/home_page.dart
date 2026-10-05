import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/pages/home_page_content.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          Center(child: HomePageContent()),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color.fromARGB(245, 241, 185, 42),
        height: 70,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: const [
          Icon(Icons.home, size: 25, color: Colors.black26),
          Icon(Icons.shopping_cart_outlined, size: 25, color: Colors.black26),
          Icon(Icons.account_circle_sharp, size: 25, color: Colors.black26),
        ],
      ),
    );
  }
}
