import 'package:flutter/material.dart';
import 'widgets/bottom_nav_bar.dart';
import 'screens/home.dart';
import 'screens/policy.dart';
import 'screens/support.dart';
import 'screens/user.dart';
import 'screens/options.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
    debugShowCheckedModeBanner: false, // debug 배너 제거
    routes: {
      // '/home': (context) => const HomeScreen(),
    },
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    PolicyScreen(),
    SupportScreen(),
    UserScreen(),
    OptionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
