import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:powerlim_pipe_trading/views/items/items_page.dart';
import 'package:powerlim_pipe_trading/views/products/products_page.dart';
import 'package:powerlim_pipe_trading/views/dashboard_page.dart';
import 'package:powerlim_pipe_trading/views/profile/profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    DashboardPage(),
    ProductsPage(),
    ItemsPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ' + user.email!),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(child: _screens.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        color: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: GNav(
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          padding: const EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          tabs: [
            GButton(icon: Icons.dashboard, text: 'Dashboard'),
            GButton(icon: Icons.shopping_bag, text: 'Products'),
            GButton(icon: Icons.list, text: 'Items'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
    );
  }
}
