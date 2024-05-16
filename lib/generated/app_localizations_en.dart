import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String login(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'email': 'email',
        'password': 'password',
        'login': 'login',
        'userLogin': 'User is successfully signed in with Google',
        'someError': 'Some error occurred',
        'other': '',
      },
    );
    return '$_temp0';
  }
}
