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

<<<<<<< HEAD
  Future<int> addUser(String name) async {
    User user = User(name: name);
    int id = await create(table: 'users', object: user);
=======
  void addUser(int id, String name) {
>>>>>>> 979501d2cb6d260ccee2453234d4c83f6fc29de4
    _users.putIfAbsent(
      id,
      () => User(
        id: id,
        name: name,
      ),
    );
    notifyListeners();
<<<<<<< HEAD
    return id;
=======
>>>>>>> 979501d2cb6d260ccee2453234d4c83f6fc29de4
  }

  User getCurrentUser() {
    return _users.containsKey(1) ? _users[1] : null;
  }
}
