import 'package:flutter/material.dart';

import '../models/Notification.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
