import 'package:flutter/material.dart';
import 'widgets/components/bottom_nav_bar.dart';
import 'screens/home.dart';
import 'screens/policy.dart';
import 'screens/support.dart';
import 'screens/user.dart';
import 'screens/options.dart';

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
    debugShowCheckedModeBanner: false, // debug 배너 제거
    theme: ThemeData(
      fontFamily: 'KoddiUD', // 전체 기본 폰트 적용
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    ),
    routes: {
      // '/home': (context) => const HomeScreen(),
    },
  ));
}

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = const [
    HomeScreen(),
    PolicyScreen(),
    SupportScreen(),
    UserScreen(),
    OptionsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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