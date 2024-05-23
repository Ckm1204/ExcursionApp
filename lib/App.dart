import 'package:excursion/generated/app_localizations.dart';
import 'package:excursion/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:excursion/utils/theme/theme.dart';
import 'package:excursion/modules/authentication/login/pages/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LoginPage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es', ''), // TODO: put here status management
      // locale: const Locale('en', ''),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Home_page(),
      }
    );
  }
}
