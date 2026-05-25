import 'package:flutter/material.dart';

class Yourproperties extends StatefulWidget {
  const Yourproperties({super.key});

  @override
  State<Yourproperties> createState() => _YourpropertiesState();
}

class _YourpropertiesState extends State<Yourproperties> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Properties")),
      body: Center(child: Text("List of your properties will be displayed here")),
    );
  }
}