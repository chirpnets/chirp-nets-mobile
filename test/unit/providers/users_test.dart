import 'package:flutter_test/flutter_test.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/models/user.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Users => ', () {
    test('Can create user provider', () {
      var userData = new Users();
      expect(userData.users, equals({}));
    });

    test('Can get current user', () async {
      var userData = new Users();
      await userData.addUser('test_user');
      expect(userData.getCurrentUser(), isInstanceOf<User>());
      expect(userData.getCurrentUser().id, equals(1));
      expect(userData.getCurrentUser().name, equals('test_user'));
    });

    test(
      'Can update user',
      () async {
        var userData = new Users();
        await userData.addUser('test_user');
        userData.updateUser(1, 'updated_user');
        expect(userData.getCurrentUser().name, equals('updated_user'));
      },
      tags: ['database'],
    );

    test(
      'Can add user to provider',
      () async {
        var userData = new Users();
        User user = new User(name: 'test_user');
        await userData.addUser(user.name);
        expect(userData.users[1].name, equals(user.name));
      },
    );
  });
}
