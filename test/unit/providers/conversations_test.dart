import 'package:chirp_nets/providers/conversations.dart';
import 'package:test/test.dart';

void main() {
  group('Conversations => ', () {
    test('Can create conversation provider', () {
      var conv = Conversations();
      expect(conv.conversations, equals({}));
    });

    test('Can add conversation', () {});
  });
}
