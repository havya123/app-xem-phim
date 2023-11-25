import 'package:baitap08/app_xem_phim.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//preview,favourite,update image, notifications, update tab film, animation, shimmer,

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(
    DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => const MovieApp(), // Wrap your app
    ),
  );
}
