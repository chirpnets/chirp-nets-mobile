import 'package:flutter_test/flutter_test.dart';
import 'unit/providers/conversations_test.dart';
import 'unit/providers/users_test.dart';
import 'unit/providers/messages_test.dart';
import 'unit/utils/database_test.dart';


main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  databaseTest();
  usersTest();
  conversationsTest();
  messagesTest();
}
