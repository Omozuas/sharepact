import 'package:flutter_riverpod/flutter_riverpod.dart';

// Avatar
final avatarProvider = StateProvider<int>((ref) => 0);


// Notification Settings
final loginAlertCheck = StateProvider<bool>((ref) => false);
final passwordChangeCheck = StateProvider<bool>((ref) => true);
final newGroupCreationCheck = StateProvider<bool>((ref) => false);
final invitationsCheck = StateProvider<bool>((ref) => true);
final messagesCheck = StateProvider<bool>((ref) => true);
final subscriptionUpdatesCheck = StateProvider<bool>((ref) => false);
final paymentRemindersCheck = StateProvider<bool>((ref) => true);
final renewalAlertsCheck = StateProvider<bool>((ref) => true);
