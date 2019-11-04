import 'package:chirp_nets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/utils/database.dart';

class Users with ChangeNotifier {
  Users() {
    init();
  }

  Map<int, User> _users = {};

  Map<int, User> get users {
    return {..._users};
  }

  void init() async {
    List<User> users = await getUsers();
    for (User user in users) {
      _users.putIfAbsent(
        user.id,
        () => user,
      );
    }
    notifyListeners();
  }

  void updateUser(int id, String name) {
    _users.update(
      id,
      (oldUser) => User(id: oldUser.id, name: name),
    );
    update(table: 'users', object: _users[id]);
    notifyListeners();
  }

  void addUser(int id, String name) {
    _users.putIfAbsent(
      id,
      () => User(
        id: id,
        name: name,
      ),
    );
    notifyListeners();
  }

  User getCurrentUser() {
    return _users.containsKey(1) ? _users[1] : null;
  }
}
