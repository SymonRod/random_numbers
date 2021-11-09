import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_numbers/models/statemanager.dart';
import 'package:random_numbers/screen/personal_list.dart';
import 'package:random_numbers/screen/personalized_quotes.dart';
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
      ChangeNotifierProvider(create: (_) => StateManager()),
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
  @override
  Widget build(BuildContext context) {
    var currentColor = Provider.of<StateManager>(context).appMainColor;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: currentColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    _dismissDialog() {
      Navigator.pop(context);
    }

    void _showMaterialDialog() async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'You ran out of numbers!',
                style: Theme.of(context).textTheme.headline5,
              ),
              content: Text(
                'You can reset the list or do nothing about it.',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _dismissDialog();
                    Provider.of<StateManager>(context, listen: false)
                        .resetNumbers();
                  },
                  child: Text(
                    'Reset Numbers',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('HelloWorld!');
                    _dismissDialog();
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          });
    }

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Container(),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        (context),
                        new MaterialPageRoute(
                            builder: (ctxt) => new Settings()));
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
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        (context),
                        new MaterialPageRoute(
                            builder: (ctxt) => new PersonalList()));
                  },
                  leading: GestureDetector(
                    child: Icon(
                      Icons.auto_awesome,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  title: Text(
                    "Personalized random pool",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: currentColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Center(
                            child: Consumer<StateManager>(
                              builder: (context, data, child) {
                                return Text(
                                  data.currentNumber.toString(),
                                  style: Theme.of(context).textTheme.headline4,
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Center(
                              child: CheckboxListTile(
                                title: Text(
                                  "Do not repeat",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                checkColor: Provider.of<StateManager>(context)
                                    .appMainColor,
                                activeColor: Colors.white,
                                onChanged: (value) {
                                  Provider.of<StateManager>(
                                    context,
                                    listen: false,
                                  ).norepeat = value!;
                                },
                                value:
                                    Provider.of<StateManager>(context).norepeat,
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shadowColor: Colors.black,
                                  enableFeedback: true,
                                ),
                                onPressed: Provider.of<StateManager>(
                                  context,
                                  listen: false,
                                ).resetNumbers,
                                child: Text(
                                  "Reset Numbers",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(child:
                        Consumer<StateManager>(builder: (context, data, child) {
                      List<Widget> radomNumers = [];

                      for (int number in data.allNumbers.reversed) {
                        radomNumers.add(Card(
                          color: data.appMainColor,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              number.toString(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ));
                      }

                      return ListView(children: radomNumers);
                    })),
                  ),
                  Consumer<StateManager>(
                    builder: (context, data, child) {
                      if (data.noNumberLeft) {
                        Future.delayed(Duration.zero, () async {
                          _showMaterialDialog();
                        });
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              const DrawerButton(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: currentColor,
          onPressed: () {
            Provider.of<StateManager>(context, listen: false).newRandom();
          },
          tooltip: 'New random number',
          child: const Icon(Icons.casino),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      height: 50,
      width: 50,
      child: GestureDetector(
        onTap: Scaffold.of(context).openDrawer,
        child: const Icon(Icons.menu),
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
    var mainBgColor = Colors.grey.shade800;

    return MaterialApp(
      title: 'Random Numbers',
      theme: ThemeData(
        cardColor: Colors.white,
        primaryColor: Provider.of<StateManager>(context).appMainColor,
        appBarTheme: AppBarTheme(
          color: Provider.of<StateManager>(context).appMainColor,
        ),
        backgroundColor: mainBgColor,
        scaffoldBackgroundColor: mainBgColor,
        dialogBackgroundColor: mainBgColor,
        iconTheme: const IconThemeData(size: 30.0, color: Colors.white),
        textTheme: const TextTheme(
            headline5: TextStyle(color: Colors.white),
            headline4: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white, fontSize: 16),
            bodyText2: TextStyle(color: Colors.white)),
        errorColor: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Provider.of<StateManager>(context).appMainColor,
          hoverColor: Provider.of<StateManager>(context).appMainColor,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
