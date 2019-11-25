import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Database functions =>', () {
    test('Can create database', () async {
      var db = await database;
      expect(db.isOpen, equals(true));
    });

    test('Can close database', () async {
      var db = await database;
      close();
      expect(db.isOpen, false);
    });

    test('Can insert into database', () async {
      var user = User(name: 'Tim');
      var users = await getUsers();
      expect(users.length, equals(0));
      int id = await create(table: 'users', object: user);
      var createdUser = await getUsers(where: 'id = ?', whereArgs: [id]);
      expect(createdUser.length, greaterThan(0));
    });

    test('Can update database entry', () async {
      var user = User(name: 'Tim');
      int id = await create(table: 'users', object: user);
      user = User(name: 'Not Tim', id: id);
      await update(table: 'users', object: user);
      var createdUser = await getUsers(where: 'id = ?', whereArgs: [id]);
      expect(createdUser[0].name, equals('Not Tim'));
    });

    test('Can delete database entry', () async {
      var user = User(name: 'Tim');
      int id = await create(table: 'users', object: user);
      var createdUser = await getUsers(where: 'id = ?', whereArgs: [id]);
      expect(createdUser.length, equals(1));
      await delete(table: 'users', id: id);
      createdUser = await getUsers(where: 'id = ?', whereArgs: [id]);
      expect(createdUser.length, equals(0));
    });
  });
}
