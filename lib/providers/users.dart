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
    if (isCurrentUser) {
      _currentUser = _users[id];
    }
    notifyListeners();
    return id;
  }

  Future init() async {
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
    if (_currentUser == null) {
      addUser('', isCurrentUser: true).then((id) {
        _users.putIfAbsent(
          id,
          () => User(
            name: '',
            isCurrentUser: true,
          ),
        );
      });
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
    if (_users[id].isCurrentUser) {
      _currentUser = _users[id];
    }
    update(table: 'users', object: _users[id]);
    notifyListeners();
  }

  User get currentUser {
    return _currentUser;
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

  static List<Map<String, dynamic>> getUsersLocations({Map<int,User> users}) {
    List<Map<String, dynamic>> userLocations = [];
    for (var user in users.values) {
      if (!user.isCurrentUser && user.latitude != null) {
        userLocations.add({
          'latitude': user.latitude,
          'longitude': user.longitude,
          'name': user.name,
        });
      }
    }
    return userLocations;
  }

  User getUser({int id}) {
    User user = _users.values.toList().firstWhere((user){
      return user.id == id;
    });
    return user;
  }
}
