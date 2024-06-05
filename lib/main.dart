// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expiry_date_tracker/components/home_page.dart';
import 'package:expiry_date_tracker/components/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
import 'package:expiry_date_tracker/providers/notification_provider.dart';
import 'package:expiry_date_tracker/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationProvider = NotificationProvider();
  await notificationProvider.initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // tz.initializeTimeZones();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );
  // AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //       channelKey: 'basic_channel',
  //       channelName: 'Basic notifications',
  //       channelDescription: "Product expiry notifications")
  // ]);
  NotificationProvider().initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool darkMode = false;
  _MainAppState() {
    getDarkModeValue();
  }
  void getDarkModeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(),
      // darkTheme: ThemeData.dark(), // standard dark theme
      // themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.blue[200],
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: Colors.blue[50], 
      //   ),
      //   scaffoldBackgroundColor: Colors.white,
      //   textTheme: const TextTheme(
      //     bodyLarge: TextStyle(color: Colors.black),
      //   ),
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: const Color.fromARGB(184, 20, 81, 116),
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: Colors.blue[50], 
      //   ),
      //   scaffoldBackgroundColor: Colors.black,
      //   textTheme: const TextTheme(
      //     bodyLarge: TextStyle(color: Colors.white),
      //   ),
      // ),
      theme: light,
      darkTheme: dark,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
