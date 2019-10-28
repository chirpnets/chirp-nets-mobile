import 'package:flutter/material.dart';
import './contacts.dart';
import '../models/user.dart';
import '../utils/database.dart';
import '../models/conversation.dart';

class ChirpNets extends StatefulWidget {
  @override
  _ChirpNetsState createState() => _ChirpNetsState();
}

class _ChirpNetsState extends State<ChirpNets> {
  void handleAddGroup() {}

  List<User> users;
  List<Conversation> groups;

  @override
  void initState() { 
    super.initState();
    //db queries go here 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chirp Nets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Groups'),
        ),
        body: Contacts(
          groups: [],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => this.handleAddGroup(),
          tooltip: 'Add Group',
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
