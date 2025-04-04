import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/profile_screen.dart';
import 'pages/discovery_screen.dart';
import 'pages/comparateur_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6D56FF),
          primary: const Color(0xFF6D56FF),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) => MainNavigation(
              initialIndex: settings.arguments as int? ?? 0,
            ),
          );
        }
        return null;
      },
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const HomePage(),
    DiscoveryScreen(),
    const Center(child: Text('Réservation')),
    const ComparateurScreen(),
    const Center(child: Text('Communaute')),
    ProfileScreen(),
  ];

  void onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Safari'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: onNavigationTap,
      ),
    );
  }
}
