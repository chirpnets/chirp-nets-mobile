import 'package:flutter/material.dart';
import '../models/user.dart';

class Contacts extends StatelessWidget {
  final List<User> groups;

  Contacts({this.groups});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            ...this.groups.map((group) => Text(group.name)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Decrement',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
