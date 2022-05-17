// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DummyScreenBoilerplate extends StatefulWidget {
  const DummyScreenBoilerplate({Key? key}) : super(key: key);

  @override
  _DummyScreenBoilerplateState createState() => _DummyScreenBoilerplateState();
}

class _DummyScreenBoilerplateState extends State<DummyScreenBoilerplate> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Expanded(child: SizedBox()),
    );
  }
}
