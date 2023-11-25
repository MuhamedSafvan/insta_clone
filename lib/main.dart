import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'utils/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: FirebaseConstants.webAPIKey,
            appId: FirebaseConstants.androidAppID,
            messagingSenderId: FirebaseConstants.senderId,
            storageBucket: FirebaseConstants.storageBucket,
            projectId: FirebaseConstants.projectID));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: LoginScreen(),
      // home: ResponsiveLayout(
      //     webScreenLayout: WebScreenLayout(),
      //     mobileScreenLayout: MobileScreenLayout()),
    );
  }
}
