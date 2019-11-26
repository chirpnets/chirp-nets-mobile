import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/device.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final Map<int, List<String>> migrations = {
  1: [
    "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, isCurrentUser INTEGER);",
    "CREATE TABLE devices(id INTEGER PRIMARY KEY, userId INTEGER, deviceRSSI TEXT, FOREIGN KEY(userId) REFERENCES users(id));",
    "CREATE TABLE conversations(id INTEGER PRIMARY KEY, userId INTEGER, name TEXT, FOREIGN KEY(userId) REFERENCES users(id));",
    "CREATE TABLE messages(id INTEGER PRIMARY KEY, conversationId INTEGER, message TEXT, createdAt TEXT, FOREIGN KEY(conversationId) REFERENCES conversations(id) ON DELETE CASCADE);",
    "ALTER TABLE devices ADD COLUMN name;",
    "ALTER TABLE messages ADD COLUMN createdBy INTEGER; ALTER TABLE messages add FOREIGN KEY(createdBy) REFERENCES users(id)",
  ]
};

Future<Database> getDatabase() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'chirpnets.db'),
    onCreate: (db, version) {
      for (var i = 1; i <= version; i++) {
        for (var migration in migrations[i]) {
          db.execute(migration);
        }
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      for (var migration in migrations[newVersion]) {
        batch.execute(migration);
      }
      await batch.commit();
    },
    version: 1,
  );
  return database;
}

Future<bool> close() async {
  var db = await database;
  await db.close();
  return !db.isOpen;
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
      isCurrentUser: maps[i]['isCurrentUser'] > 0 ? true : false,
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

  final maps = await db.query('devices', where: where, whereArgs: whereArgs);

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
