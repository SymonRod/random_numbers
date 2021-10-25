import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_numbers/models/data.dart';
import 'package:random_numbers/screen/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainBgColor = Colors.grey.shade700;

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Data()),
    ], child: MainPage());
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
                onTap: () {
                  Navigator.push((context),
                      new MaterialPageRoute(builder: (ctxt) => new Settings()));
                },
                leading: GestureDetector(
                  child: Icon(
                    Icons.settings,
                    color: Theme.of(context).cardColor,
                  ),
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
              ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<Data>(builder: (context, data, child) {
                return Text(
                  data.currentNumber.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<Data>(context, listen: false).newRandom();
          },
          tooltip: 'New random number',
          child: const Icon(Icons.casino),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var mainAppColor = Provider.of<Data>(context).appMainColor;
    var mainBgColor = Colors.grey.shade800;

    return MaterialApp(
      title: 'Random Numbers',
      theme: ThemeData(
        cardColor: Colors.white,
        primarySwatch: Colors.red,
        backgroundColor: mainBgColor,
        scaffoldBackgroundColor: mainBgColor,
        dialogBackgroundColor: mainBgColor,
        iconTheme: const IconThemeData(size: 30.0, color: Colors.white),
        textTheme: const TextTheme(
            headline4: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white, fontSize: 16),
            bodyText2: TextStyle(
              color: Colors.white,
            )),
        inputDecorationTheme: InputDecorationTheme(),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
