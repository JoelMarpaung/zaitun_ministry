import 'package:flutter/material.dart';
import 'package:radio/presentation/pages/radio_page.dart';
import 'package:schedule/presentation/pages/schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    SchedulePage(),
    const RadioPage(),
    const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            _selectedIndex == 1 ? Colors.blue[900] : Colors.blue[700],
        onPressed: () {
          _onItemTapped(1);
        },
        child: const Icon(Icons.radio),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 70,
                color:
                    _selectedIndex == 0 ? Colors.blue[900] : Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.schedule),
                  color: Colors.white,
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 70,
                color:
                    _selectedIndex == 2 ? Colors.blue[900] : Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.info_outline),
                  color: Colors.white,
                  onPressed: () {
                    _onItemTapped(2);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
