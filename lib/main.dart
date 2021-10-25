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
  @override
  Widget build(BuildContext context) {
    var currentColor = Provider.of<Data>(context).appMainColor;

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
          backgroundColor: currentColor,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: currentColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Consumer<Data>(
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
                            controlAffinity: ListTileControlAffinity.leading,
                            checkColor: Provider.of<Data>(context).appMainColor,
                            activeColor: Colors.white,
                            onChanged: (value) {
                              Provider.of<Data>(
                                context,
                                listen: false,
                              ).norepeat = value!;
                            },
                            value: Provider.of<Data>(context).norepeat,
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
                            onPressed: Provider.of<Data>(
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
                child: Container(
                    child: Consumer<Data>(builder: (context, data, child) {
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
                    // Container(
                    //   margin: EdgeInsets.all(5),
                    //   padding: EdgeInsets.all(20),
                    //   decoration: BoxDecoration(
                    //       color: data.appMainColor,
                    //       borderRadius: BorderRadius.circular(20)),
                    //   child: Text(
                    //     number.toString(),
                    //     style: Theme.of(context).textTheme.bodyText1,
                    //   ),
                    // ));
                  }

                  return ListView(children: radomNumers);
                })),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: currentColor,
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
    var mainBgColor = Colors.grey.shade800;

    return MaterialApp(
      title: 'Random Numbers',
      theme: ThemeData(
        cardColor: Colors.white,
        primaryColor: Provider.of<Data>(context).appMainColor,
        appBarTheme: AppBarTheme(
          color: Provider.of<Data>(context).appMainColor,
        ),
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
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Provider.of<Data>(context).appMainColor,
          hoverColor: Provider.of<Data>(context).appMainColor,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
