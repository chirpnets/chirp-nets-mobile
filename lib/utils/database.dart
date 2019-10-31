import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/contact.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/device.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final List<String> migrations = [
  "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT);",
  "CREATE TABLE device(id INTEGER PRIMARY KEY, userId INTEGER, deviceRSSI TEXT, FOREIGN KEY(userId) REFERENCES users(id));",
  "CREATE TABLE conversations(id INTEGER PRIMARY KEY, userId INTEGER, name TEXT, FOREIGN KEY(userId) REFERENCES users(id));",
  "CREATE TABLE messages(id INTEGER PRIMARY KEY, conversationId INTEGER, message TEXT, createdAt TEXT, FOREIGN KEY(conversationId) REFERENCES conversations(id));",
  "CREATE TABLE contact(id INTEGER PRIMARY KEY, conversationId INTEGER, name TEXT, deviceId TEXT, FOREIGN KEY(conversationId) REFERENCES conversations(id));",
  "ALTER TABLE device ADD COLUMN name;",
  "ALTER TABLE messages ADD COLUMN createdBy INTEGER; ALTER TABLE messages add FOREIGN KEY(createdBy) REFERENCES users(id)",
  "ALTER TABLE contact ADD COLUMN userId INTEGER; ALTER TABLE contact add FOREIGN KEY(userId) REFERENCES users(id)",
];

Future<Database> getDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'chirpnets.db'),
    onCreate: (db, version) {
      for (var script in migrations) {
        db.execute(script);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      print(oldVersion);
      print(newVersion);
      for (var i = oldVersion - 1; i == newVersion - 1; i++) {
        batch.execute(migrations[i]);
      }
      await batch.commit();
    },
    version: migrations.length,
  );
  return database;
}

void close() async {
  var db = await database;
  await db.close();
}

final Future<Database> database = getDatabase();

Future<int> create({String table, dynamic object}) async {
  final Database db = await database;

  return await db.insert(
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
Future<List<User>> getUsers({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('users', where: where, whereArgs: whereArgs);

  if (maps == null) {
    return [];
  }

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

Future<List<Conversation>> getConversations({where, whereArgs}) async {
  final Database db = await database;

  final maps =
      await db.query('conversations', where: where, whereArgs: whereArgs);

  if (maps == null) {
    return [];
  }

  return List.generate(maps.length, (i) {
    return Conversation(
      id: maps[i]['id'],
      name: maps[i]['name'],
      userId: maps[i]['userId'],
    );
  });
}

Future<List<Device>> getDevices({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('device', where: where, whereArgs: whereArgs);

  if (maps == null) {
    return [];
  }

  return List.generate(maps.length, (i) {
    return Device(
      id: maps[i]['id'],
      userId: maps[i]['userId'],
      deviceRSSI: maps[i]['deviceRSSI'],
    );
  });
}

Future<List<Message>> getMessages({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('messages', where: where, whereArgs: whereArgs);

  if (maps == null) {
    return [];
  }

  return List.generate(maps.length, (i) {
    return Message(
      id: maps[i]['id'],
      message: maps[i]['message'],
      conversationId: maps[i]['conversationId'],
      createdAt: DateTime.tryParse(maps[i]['createdAt']),
      createdBy: maps[i]['createdBy'],
    );
  });
}

Future<List<Contact>> getContacts({where, whereArgs}) async {
  final Database db = await database;

  final maps = await db.query('contacts', where: where, whereArgs: whereArgs);

  if (maps == null) {
    return [];
  }

  return List.generate(maps.length, (i) {
    return Contact(
      id: maps[i]['id'],
      conversationId: maps[i]['conversationId'],
      name: maps[i]['name'],
    );
  });
}
