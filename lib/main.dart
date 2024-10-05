import 'package:JazakAllah/purchase/purchase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';
import 'constants/localization/dependency_inj.dart';
import 'data/viewmodel/Providers/counter_provider.dart';
import 'data/viewmodel/Providers/gpt_provider.dart';
import 'data/viewmodel/Providers/hadith_provider.dart';
import 'data/viewmodel/Providers/link_provider.dart';
import 'data/viewmodel/Providers/location_provider.dart';
import 'data/viewmodel/Providers/note_provider.dart';
import 'data/viewmodel/Providers/user_provider.dart';
import 'data/viewmodel/Providers/wallpaper_provider.dart';
import 'data/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationServices().initNotification();
  tz.initializeTimeZones();

  //.env file define
  await dotenv.load(fileName: "assets/.env");

  //Initialize Firebase
  try {
    await Firebase.initializeApp();
    print('Firebase initialize successfully');
  } catch (e) {
    print('Error initializing firebase: $e');
  }

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['oneSignalKey'].toString());
  OneSignal.Notifications.requestPermission(true).then((accepted) {
    print("Accepted permission: $accepted");
  });

  Map<String, Map<String, String>> _languages = await LanguageDependency.init();

  // Initialize InApp Purchase
  await PurchaseApi.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // systemNavigationBarColor: AppColors.colorPrimary,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => ZikirProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => HadithProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => GPTProvider()),
        ChangeNotifierProvider(create: (context) => WallPaperProvider()),
        ChangeNotifierProvider(create: (context) => LinkProvider()),
      ],
      child: JazakAllah(languages: _languages),
    ),
  );
}
