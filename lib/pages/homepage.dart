import 'package:flutter/material.dart';
import 'package:radio/presentation/pages/radio_page.dart';
import 'package:schedule/presentation/pages/schedule_page.dart';
import 'package:info/presentation/pages/info_page.dart';

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
    const SchedulePage(),
    const RadioPage(),
    const InfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(
            color: Colors.brown.shade400,
            width: 2.0,
          ),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          _onItemTapped(1);
        },
        child: Icon(Icons.radio, color: _selectedIndex == 1 ? Colors.blue[900] : Colors.brown[400]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.brown.shade400, width: 2))),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.event_note),
                color: _selectedIndex == 0 ? Colors.blue[900] : Colors.brown[400],
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                color: _selectedIndex == 2 ? Colors.blue[900] : Colors.brown[400],
                onPressed: () {
                  _onItemTapped(2);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
