import 'package:chirp_nets/providers/messages.dart';
import 'package:test/test.dart';

void main() {
  group('Messages => ', () {
    test('Can create message provider', () {
      var messages = new Messages();
      expect(messages.messages, equals({}));
    });

    test('Can ', () {});
  });
}
