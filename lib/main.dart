import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'screens/game_screen.dart';
import 'utils/constants.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Unity Ads
  UnityAds.init(
    gameId: AdConstants.gameId,
    testMode: true, // Set to false for production
    onComplete: () => print('Unity Ads initialization complete'),
    onFailed: (error, message) => print('Unity Ads initialization failed: $message'),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اضرب بشار الأسد',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Cairo', // Arabic-friendly font
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      // Set the app to run in RTL for Arabic text
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
      ],
      locale: const Locale('ar', ''),
      home: const GameScreen(),
    );
  }
}
