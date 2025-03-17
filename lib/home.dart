import 'package:flutter/material.dart';
import 'package:simpleqr/screens/createqr.dart';
import 'package:simpleqr/screens/scanqr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SimpleQr")),
      body: IndexedStack(
        index: _selectedIndex,
        children: [Scanqr(), Createqr()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Scan",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Create"),
        ],
      ),
    );
  }
}
