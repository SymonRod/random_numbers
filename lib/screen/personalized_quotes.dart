import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_numbers/models/statemanager.dart';

class PersonalizedQuotes extends StatefulWidget {
  const PersonalizedQuotes({Key? key}) : super(key: key);

  @override
  _PersonalizedQuotesState createState() => _PersonalizedQuotesState();
}

class _PersonalizedQuotesState extends State<PersonalizedQuotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<StateManager>(context).appMainColor,
      ),
      body: Container(
        child: Text(""),
      ),
    );
  }
}
