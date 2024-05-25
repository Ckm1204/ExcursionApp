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
        'username': 'Username',
        'userLogin': 'User is successfully signed in with Google',
        'someError': 'Some error occurred',
        'loginGoogle': 'Sign in with Google',
        'dontHaveAcc': 'Don\'t have an account?',
        'signUp': 'signUp',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String signUp(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'alHaveAcc': 'Already have an account?',
        'username': 'Username',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String home(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'welcome': 'Welcome',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String nav_bar(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'profile': 'Perfil',
        'search': 'Search',
        'home': 'Home',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String card_firestore(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'department': 'Department',
        'location': 'Location',
        'name': 'Name',
        'rating': 'rating',
        'weather': 'Weather',
        'description': 'Description',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String search(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'searchTitle1': 'Search by name or department',
        'notFound': 'no places found',
        'other': '',
      },
    );
    return '$_temp0';
  }
}
