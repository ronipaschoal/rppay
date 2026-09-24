import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/device_frame.dart';
import '../features/splash/presentation/views/splash_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPPay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) => DeviceFrame(child: child!),
      home: const SplashPage(),
    );
  }
}
