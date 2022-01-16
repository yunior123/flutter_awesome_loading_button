import 'package:flutter/material.dart';
import 'package:flutter_awesome_loading_button/flutter_awesome_loading_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Loading Button Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Awesome Loading Button Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: AwesomeLoadingButton(
          loadingIndicatorColor: Colors.blue,
          loadingIndicatorValueColor: const AlwaysStoppedAnimation(
            Colors.blueAccent,
          ),
          onPressed: () async {
            await Future.delayed(
              const Duration(
                seconds: 5,
              ),
            );
          },
          text: 'Fetch',
        ),
      ),
    );
  }
}
