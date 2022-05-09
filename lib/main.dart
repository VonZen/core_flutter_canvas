import 'package:core_flutter_canvas/ch1/cfc_ch1_1.dart';
import 'package:core_flutter_canvas/ch1/cfc_ch1_2.dart';
import 'package:core_flutter_canvas/ch1/cfc_ch1_3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Core Flutter Canvas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> chapters = [
    '1. Essentials',
    '2. Drawing',
    '3. Text',
    '4. Images and Video',
    '5. Animation',
    '6. Sprites',
    '7. Physics',
    '8. Collision Detection',
    '9. Game Development',
    '10. Custom Controls',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Core Flutter Canvas')),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  // return const CFCCH11();
                  // return const CFCCH12();
                  return const CFCCH13();
                }));
              },
              title: Text(chapters[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1,
              color: const Color.fromARGB(255, 0, 105, 92),
            );
          },
          itemCount: chapters.length),
    );
  }
}
