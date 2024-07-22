import 'package:sharepact_app/screens/notification/model/notification_model.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';

List<NotificationModel> allNotifications = [
  NotificationModel(
    isNew: true,
    icon: AppImages.personTick,
    title: "New login detected from a new device",
    time: "(Just now)",
    type: NotificationType.Login,
  ),
  NotificationModel(
    isNew: true,
    icon: AppImages.lock,
    title: "Your password was successfully changed",
    time: "(2 hrs ago)",
    type: NotificationType.Password,
  ),
  NotificationModel(
    isNew: false,
    icon: AppImages.peopleIcon,
    title: "You have successfully created the group 'Spotify Friends’",
    time: "(5 hrs ago)",
    type: NotificationType.Group,
  ),
  NotificationModel(
    isNew: false,
    icon: AppImages.sendIcon,
    title: "Invitation to join 'Canva Designers' has been sent",
    time: "(5 hrs ago)",
    type: NotificationType.Invitation,
  ),
  NotificationModel(
    isNew: false,
    icon: AppImages.messageIcon,
    title: "John Doe sent a new message in 'Prime Video Group'",
    time: "(5 hrs ago)",
    type: NotificationType.Message,
  ),
  NotificationModel(
    isNew: false,
    icon: AppImages.walletIcon,
    title: "Payment reminder: Your 'Hulu' subscription is due in 3 days",
    time: "(5 hrs ago)",
    type: NotificationType.Payment,
  ),
];
