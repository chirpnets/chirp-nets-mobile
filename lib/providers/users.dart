import 'package:chirp_nets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/utils/database.dart';

class Users with ChangeNotifier {
  Users() {
    init();
  }

  Map<int, User> _users = {};
  User _currentUser;

  Map<int, User> get users {
    return {..._users};
  }

  void init() async {
    List<User> users = await getUsers();
    for (User user in users) {
      if (user.isCurrentUser) {

        _currentUser = user;
      }
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
      (oldUser) => User(
        id: oldUser.id,
        name: name,
        isCurrentUser: oldUser.isCurrentUser,
      ),
    );
    update(table: 'users', object: _users[id]);
    notifyListeners();
  }

  Future<int> addUser(String name, {bool isCurrentUser = false}) async {
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

  User get currentUser {
    return _currentUser;
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

  void deleteUser(int id) {
    delete(table: 'users', id: id);
    _users.remove(id);
    notifyListeners();
  }

  void updateLocation({int id, double latitude, double longitude}) {
    User user = _users.update(
      id,
      (oldUser) => User(
        id: oldUser.id,
        name: oldUser.name,
        isCurrentUser: oldUser.isCurrentUser,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      ),
    );
    update(table: 'users', object: user);
    notifyListeners();
  }

  List<Map<String, dynamic>> getUsersLocations() {
    List<Map<String, dynamic>> userLocations = [];
    for (var user in _users.values) {
      if (!user.isCurrentUser) {
        userLocations.add({
          'latitude': user.latitude,
          'longitude': user.longitude,
          'name': user.name,
        });
      }
    }
    return userLocations;
  }
}
