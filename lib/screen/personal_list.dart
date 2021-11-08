import 'package:flutter/material.dart';

class PersonalList extends StatefulWidget {
  const PersonalList({Key? key}) : super(key: key);

  @override
  _PersonalListState createState() => _PersonalListState();
}

class _PersonalListState extends State<PersonalList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Personal list"),
        ),
        body: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
