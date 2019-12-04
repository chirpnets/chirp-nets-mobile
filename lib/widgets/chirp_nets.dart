import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/bluetooth_screen.dart';
import 'package:chirp_nets/screens/compass_screen.dart';
import 'package:chirp_nets/utils/theme.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/screens/conversations_screen.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ChirpNets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chirp Nets',
      theme: primaryTheme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Conversations(),
          ),
          ChangeNotifierProvider.value(
            value: Users(),
          ),
          ChangeNotifierProvider.value(
            value: Messages(),
          ),
        ],
        child: ConversationsScreen(),
      ),
      routes: {
        MessagesScreen.routeName: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Users(),
                ),
                ChangeNotifierProvider.value(
                  value: Messages(),
                ),
              ],
              child: MessagesScreen(),
            ),
        SettingsScreen.routeName: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Users(),
                ),
              ],
              child: SettingsScreen(),
            ),
        BluetoothScreen.routeName: (ctx) => MultiProvider(
              providers: [],
              child: BluetoothScreen(),
            ),
        CompassScreen.routeName: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: Users(),
                ),
              ],
              child: CompassScreen(),
            ),
      },
    );
  }
}
