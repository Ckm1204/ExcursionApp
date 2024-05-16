import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String login(String name) {
    String _temp0 = intl.Intl.selectLogic(
      name,
      {
        'email': 'correo electrónico',
        'password': 'contraseña',
        'login': 'iniciar sesión',
        'userLogin': 'Usuario inicio sesion  correctamente con Google ',
        'someError': 'Algo salió mal',
        'otherError': 'Ocurrió un error inesperado',
        'other': 'Ocurrió un error inesperado',
      },
    );
    return '$_temp0';
  }
}
