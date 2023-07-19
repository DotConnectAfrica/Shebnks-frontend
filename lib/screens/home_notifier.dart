import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/NotificationProvider.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // List<String> notifications = [];

  @override
  Widget build(BuildContext context) {
    final notificationsProvider = Provider.of<NotificationsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: notificationsProvider.notifications.isNotEmpty
          ? ListView.builder(
        itemCount: notificationsProvider.notifications.length,
        itemBuilder: (BuildContext context, int index) {
          final notification = notificationsProvider.notifications[index];
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.body),
          );
        },
      )
          : Center(
        child: Text(
          'No notifications',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
