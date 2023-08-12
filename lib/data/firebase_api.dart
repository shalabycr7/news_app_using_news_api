import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBack(RemoteMessage messege) async {
  print('title ${messege.notification?.title}');
  print('body ${messege.notification?.body}');

  print('payload ${messege.data}');
}

class FireBaseApi {
  final fireMes = FirebaseMessaging.instance;

  Future<void> intitNot() async {
    await fireMes.requestPermission();
    final fCTok = await fireMes.getToken();
    print('The token is (${fCTok})');
    FirebaseMessaging.onBackgroundMessage(handleBack);
  }
}
