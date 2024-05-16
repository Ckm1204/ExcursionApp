
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:excursion/generated/app_localizations.dart';

import '../../generated/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Locale _currentLocale = Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _currentLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('es', ''), // Spanish
      ],
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.chooseLanguage),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<Locale>(
                value: _currentLocale,
                items: <DropdownMenuItem<Locale>>[
                  DropdownMenuItem<Locale>(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem<Locale>(
                    value: Locale('es'),
                    child: Text('Español'),
                  ),
                ],
                onChanged: (Locale? newValue) {
                  setState(() {
                    _currentLocale = newValue!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.loremIpsum),
            ],
          ),
        ),
      ),
    );
  }
}