import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:flutter_test/flutter_test.dart';

void messagesTest() {
  int convId;
  int userId;
  var conversationProvider = Conversations();
  var userProvider = Users();
  var messageProvider = Messages();

  setUp(() async {
    userId = await userProvider.addUser('Tim');
    convId = await conversationProvider.addConversation(userId, 'Name', 1);
  });

  tearDown(() {
    for (var id in messageProvider.messages.keys) {
      messageProvider.deleteMessage(id);
    }
    for (var id in conversationProvider.conversations.keys) {
      conversationProvider.deleteConversation(id);
    }
    for (var id in userProvider.users.keys) {
      userProvider.deleteUser(id);
    }
  });

  group('Messages => ', () {
    test('Can create message provider', () {
      expect(messageProvider.messages, equals({}));
    });

    test('Can add message to provider', () async {
      int messageId = await messageProvider.addMessage(
        userId,
        convId,
        'Message',
        DateTime(2019),
      );
      var messageList = messageProvider.messages;
      // expect(messageList[messageId].message, equals('Message'));
    });
  });
}
