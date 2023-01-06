import 'package:flutter/material.dart';
import 'package:shrink_animation_button/shrink_animation_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _height = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShrinkAnimationCard(
              child: Padding(
                padding: EdgeInsets.all(_height),
                child: const Text("Container Button"),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ShrinkAnimationContainer(
              height: _height,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: const Text("Container Button"),
            ),
          ],
        ),
      ),
    );
  }
}
