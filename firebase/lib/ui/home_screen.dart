import 'package:firebase/ui/bottom_nav_pages/favorite_page.dart';
import 'package:firebase/ui/bottom_nav_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'bottom_nav_pages/cart_page.dart';
import 'bottom_nav_pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late int _selectedIndex=0;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HomePage(),
      FavoritePage(),
      CartPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body:pages[_selectedIndex],
      bottomNavigationBar: GNav(
        backgroundColor: Colors.blue.shade100,
        tabs: const [
          GButton(icon: Icons.home_filled,text: 'Home',gap: 8,iconColor: Colors.orangeAccent,hoverColor: Colors.blue,duration: Duration(seconds: 1),),
          GButton(icon: Icons.favorite,text: 'Favorite',gap: 8,iconColor: Colors.redAccent,hoverColor: Colors.blue,duration: Duration(seconds: 1),),
          GButton(icon: Icons.shopping_cart,text: 'Cart',gap: 8,iconColor: Colors.blueAccent,hoverColor: Colors.blue,duration: Duration(seconds: 1),),
          GButton(icon: Icons.account_circle,text: 'Profile',gap: 8,iconColor: Colors.pinkAccent,hoverColor: Colors.blue,duration: Duration(seconds: 1),),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      ),
    );
  }
}
