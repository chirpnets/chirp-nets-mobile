import '../models/user.dart';
import '../models/contact.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../models/device.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

Future<Database> getDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'chirpnets.db'),
    onCreate: (db, version) {
      return db.execute(
        """
          CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT); 
          CREATE TABLE device(id INTEGER PRIMARY KEY, userId INTEGER, deviceRSSI TEXT, FOREIGN KEY(userId) REFERENCES users(id));
          CREATE TABLE conversations(id INTEGER PRIMARY KEY, userId INTEGER, name TEXT, FOREIGN KEY(userId) REFERENCES users(id));
          CREATE TABLE messages(id INTEGER PRIMARY KEY, conversationId INTEGER, message TEXT, createdAt TEXT, FOREIGN KEY(conversationId) REFERENCES conversations(id));
          CREATE TABLE contact(id INTEGER PRIMARY KEY, conversationId INTEGER, name TEXT, FOREIGN KEY(conversationId) REFERENCES conversations(id));
        """,
      );
    },
    version: 1,
  );
  return database;
}

final Future<Database> database = getDatabase();

Future<void> create({String table, dynamic object}) async {
  final Database db = await database;
  await db.insert(
    table,
    object.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> update({String table, dynamic object}) async {
  final Database db = await database;

  await db.update(
    table,
    object.toMap(),
    where: "id = ?",
    whereArgs: [object.id],
  );
}

Future<void> delete({String table, int id}) async {
  final Database db = await database;
  await db.delete(
    table,
    where: "id = ?",
    whereArgs: [id],
  );
}

// Getters for models
Future<List<dynamic>> getUsers({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('users', where: where, whereArgs: whereArgs);
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<List<dynamic>> getConversations({where, whereArgs}) async {
  final Database db = await database;

  final maps =
      await db.query('conversations', where: where, whereArgs: whereArgs);
  return List.generate(maps.length, (i) {
    return Conversation(
      id: maps[i]['id'],
      name: maps[i]['name'],
      userId: maps[i]['userId'],
    );
  });
}

Future<List<dynamic>> getDevices({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('devices', where: where, whereArgs: whereArgs);
  return List.generate(maps.length, (i) {
    return Device(
      id: maps[i]['id'],
      userId: maps[i]['userId'],
      deviceRSSI: maps[i]['deviceRSSI'],
    );
  });
}

Future<List<dynamic>> getMessages({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('messages', where: where, whereArgs: whereArgs);
  return List.generate(maps.length, (i) {
    return Message(
      id: maps[i]['id'],
      message: maps[i]['message'],
      conversationId: maps[i]['conversationIid'],
      createdAt: maps[i]['createdAt'],
    );
  });
}

Future<List<dynamic>> getContacts({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('contacts', where: where, whereArgs: whereArgs);
  return List.generate(maps.length, (i) {
    return Contact(
      id: maps[i]['id'],
      conversationId: maps[i]['conversationId'],
      name: maps[i]['name'],
    );
  });
}
