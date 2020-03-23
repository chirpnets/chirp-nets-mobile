import 'package:flutter_test/flutter_test.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/models/user.dart';

void usersTest() {
  var userData = new Users();

  setUp(() {
    for (var id in userData.users.keys) {
      userData.deleteUser(id);
    }
  });

  tearDown(() {
    for (var id in userData.users.keys) {
      userData.deleteUser(id);
    }
  });

  group('Users => ', () {
    test('Can create user provider', () {
      var userData = new Users();
      expect(userData.users, equals({}));
    });

    test('Can get current user', () async {
      var id = await userData.addUser(name:'test_user', nodeId: 0, isCurrentUser: true);
      expect(userData.currentUser, isInstanceOf<User>());
      expect(userData.currentUser.id, equals(id));
      expect(userData.currentUser.name, equals('test_user'));
    });

    test(
      'Can update user',
      () async {
        var id = await userData.addUser(name: 'test_user', nodeId: 0);
        userData.updateUser(id, name:'updated_user');
        expect(userData.users[id].name, equals('updated_user'));
      },
    );

    test(
      'Can add user to provider',
      () async {
        User user = new User(name: 'test_user');
        var id = await userData.addUser(name:user.name, nodeId: 0);
        expect(userData.users[id].name, equals(user.name));
      },
    );
  });
}
