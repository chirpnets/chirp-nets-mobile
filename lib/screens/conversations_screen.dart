import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/compass_screen.dart';
import 'package:chirp_nets/screens/settings_screen.dart';
import 'package:chirp_nets/widgets/conversations/add_conversation_widget.dart';
import 'package:chirp_nets/widgets/conversations/conversations_list_widget.dart';
import 'package:chirp_nets/widgets/users/add_first_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class ConversationsScreen extends StatefulWidget {
  ConversationsScreen();

  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  Users userData;

  var location = new Location();

  fetchLocation(LocationData currentLocation) async {
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        var error = 'User denied location permissions';
        debugPrint(error);
      }
      currentLocation = null;
    }
    if (currentLocation != null && userData != null) {
      if (userData.currentUser != null) {
        userData.updateLocation(
          id: userData.currentUser.id,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((LocationData currentLocation) {
      fetchLocation(currentLocation);
    });
  }

  void getBottomSheet(userData, context, conversationData) {
    User user = userData.currentUser;
    double height = MediaQuery.of(context).size.height * 0.6;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.height;
    }
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: height,
        child: user == null
            ? AddFirstUserWidget(
                userData: userData,
                conversationData: conversationData,
              )
            : AddConversationWidget(
                conversationData: conversationData,
                user: user,
              ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<Users>(context);
    final Conversations conversationData = Provider.of<Conversations>(context);
    Map<int, Conversation> conversations = conversationData.conversations;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: Theme.of(context).textTheme.title,
        ),
        actions: [
          FlatButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(CompassScreen.routeName),
            child: Icon(
              Icons.my_location,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          FlatButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
            child: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Center(
        child: ConversationsListWidget(
          currentUser: userData.currentUser,
          conversations: conversations,
          conversationData: conversationData,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
        tooltip: 'Add Conversation',
        onPressed: () => getBottomSheet(userData, context, conversationData),
      ),
    );
  }
}
