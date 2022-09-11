import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'gallery_page.dart';
import 'my_camera.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<XFile> listImages = [];

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyCameraWidget(),
    GalleryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
            BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Galery')
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
