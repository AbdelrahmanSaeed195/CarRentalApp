import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project3/main.dart';
import 'package:project3/screen/notifications_screen.dart';

class FirebaseNotifications {
  // create instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;
  //initialize notification for this app or device
  Future<void> initnotifications() async {
    // request permission from user
    await _firebaseMessaging.requestPermission();
    // fetch the token
    final fthToken = await FirebaseMessaging.instance.getToken();
    // print the token 
    print("Token : $fthToken");

    //initialize furhter settings for push notification
    handleBackgroundNotification();
  }

  //handle notifications when recieved
  void handleMessge(RemoteMessage? message) {
    // if the message is null do noting
    if (message == null) return;
    // navigate to new screen when message is received users taps notifiaction
    navigatorKey.currentState?.pushNamed(NotificationsScreen.id, arguments: message);
  }

  // function to initialize background settings 
  Future handleBackgroundNotification() async { 
   // handle notifications in case when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then(handleMessge);
    // attach event listeners when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessge);
  }
   
}
