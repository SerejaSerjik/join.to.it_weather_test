import 'package:flutter/material.dart';
import 'package:weather_test/presentation/presentation.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MapPage(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(0, 'MAP'),
                _buildButton(1, 'SEARCH'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(int index, String text) {
    final isActive = _selectedIndex == index;
    return Expanded(
      child: SizedBox(
        height: 70,
        child: ElevatedButton(
          onPressed: () => setState(() => _selectedIndex = index),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor:
                isActive ? Colors.blue : Colors.blue.shade200, // Text color
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
