import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:random_numbers/models/statemanager.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var minValueController = TextEditingController();
  var maxValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    minValueController.text = Provider.of<StateManager>(context).min.toString();
    maxValueController.text = Provider.of<StateManager>(context).max.toString();

    var currentColor = Provider.of<StateManager>(context).appMainColor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Random number range:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 40,
                          width: 50,
                          child: TextField(
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                            controller: minValueController,
                            keyboardType: TextInputType.number,
                            onEditingComplete: () {
                              Provider.of<StateManager>(context, listen: false)
                                  .min = int.parse(minValueController.text);
                            },
                            onSubmitted: (value) {
                              if (value != "") {
                                Provider.of<StateManager>(context,
                                        listen: false)
                                    .min = int.parse(value);
                              }
                            },
                          ),
                        ),
                        Text(
                          "  -  ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Container(
                          width: 50,
                          height: 40,
                          child: TextField(
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                            controller: maxValueController,
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              if (value != "") {
                                Provider.of<StateManager>(context,
                                        listen: false)
                                    .max = int.parse(value);
                              }
                            },
                            onEditingComplete: () {
                              Provider.of<StateManager>(context, listen: false)
                                  .min = int.parse(maxValueController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Change app color",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              titlePadding: const EdgeInsets.all(0.0),
                              contentPadding: const EdgeInsets.all(0.0),
                              content: SingleChildScrollView(
                                child: MaterialPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: (newColor) {
                                    Provider.of<StateManager>(context,
                                            listen: false)
                                        .appMainColor = newColor;
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Change me'),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Provider.of<StateManager>(context).appMainColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
