import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainBgColor = Colors.grey.shade800;

    return MaterialApp(
      title: 'Random Numbers',
      theme: ThemeData(
        cardColor: Colors.white,
        primarySwatch: Colors.red,
        backgroundColor: mainBgColor,
        scaffoldBackgroundColor: mainBgColor,
        dialogBackgroundColor: mainBgColor,
        iconTheme: IconThemeData(size: 30.0, color: Colors.white),
        textTheme: TextTheme(
          headline4: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  var rand = Random();
  void _incrementCounter() {
    setState(() {
      _counter = rand.nextInt(200);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).cardColor,
                ),
                title: Text(
                  "Impostazioni",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ]),
          ),
        ),
        appBar: AppBar(
          title: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.casino),
        ),
      ),
    );
  }
}
