import 'package:chirp_nets/providers/bluetooth.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/bluetooth_screen.dart';
import 'package:chirp_nets/screens/compass_screen.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/utils/theme.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:chirp_nets/widgets/common/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/screens/conversations_screen.dart';
import 'package:chirp_nets/screens/messages_screen.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ChirpNets extends StatefulWidget {
  @override
  _ChirpNetsState createState() => _ChirpNetsState();
}

class _ChirpNetsState extends State<ChirpNets> {
  Bluetooth bluetooth;
  @override
  void initState() {
    super.initState();
    Bluetooth bluetooth = Bluetooth();
    bluetooth.findDevices();
    Fluttertoast.showToast(
      msg: deviceConnectingMessage,
    );
    setState(() {
      this.bluetooth = bluetooth;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bluetooth.cancelScan();
    bluetooth.disconnectDevice();
    Fluttertoast.showToast(
      msg: 'disconnected',
    );
  }

  @override
  Widget build(BuildContext context) {
    Conversations conversationProvider = Conversations();
    Messages messageProvider = Messages();
    Users userProvider = Users();
    return Background(
      child: MaterialApp(
        title: 'Chirp Nets',
        theme: primaryTheme,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: conversationProvider,
            ),
            ChangeNotifierProvider.value(
              value: userProvider,
            ),
            ChangeNotifierProvider.value(
              value: messageProvider,
            ),
            ChangeNotifierProvider.value(
              value: bluetooth,
            ),
          ],
          child: ConversationsScreen(),
        ),
        routes: {
          MessagesScreen.routeName: (ctx) => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: userProvider,
                  ),
                  ChangeNotifierProvider.value(
                    value: messageProvider,
                  ),
                  ChangeNotifierProvider.value(
                    value: bluetooth,
                  ),
                ],
                child: MessagesScreen(),
              ),
          SettingsScreen.routeName: (ctx) => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: userProvider,
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
                    value: userProvider,
                  ),
                ],
                child: CompassScreen(),
              ),
        },
      ),
    );
  }
}
