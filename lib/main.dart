import 'package:flutter/material.dart';
import 'package:untitled5/src/core/di/di.dart';
 import 'src/features/get_weather/presentation/view/screens/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherPage(),
    );
  }
}
