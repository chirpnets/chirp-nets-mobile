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
      (oldUser) => User(id: oldUser.id, name: name, isCurrentUser: oldUser.isCurrentUser),
    );
    update(table: 'users', object: _users[id]);
    notifyListeners();
  }

  Future<int> addUser(String name, {bool isCurrentUser=false}) async {
    User user = User(name: name, isCurrentUser: isCurrentUser);
    int id = await create(table: 'users', object: user);
    _users.putIfAbsent(
      id,
      () => User(
        id: id,
        name: name,
        isCurrentUser: isCurrentUser,
      ),
    );
    notifyListeners();
    return id;
  }

  User getCurrentUser() {
    var users = _users.values;
    for (var user in users) {
      if (user.isCurrentUser) {
        return user;
      }
    }
    return null;
  }

  void deleteUser (int id) {
    delete(table: 'users', id:id);
    _users.remove(id);
    notifyListeners();
  }
}
