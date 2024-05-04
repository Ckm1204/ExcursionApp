import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([super.locale = 'es']);

  @override
  String get appTitle => 'Mi Aplicación';

  @override
  String get content => 'Hola';

  @override
  String onboarding(String name) {
    String temp0 = intl.Intl.selectLogic(
      name,
      {
        'onBoardingTitle1': 'Elija su producto',
        'onBoardingSubTitle1': 'Bienvenido a un mundo de opciones ilimitadas: ¡su producto perfecto le espera!',
        'onBoardingTitle2': 'Seleccione el método de pago',
        'onBoardingSubTitle2': 'Para realizar transacciones sin problemas, elija su forma de pago',
        'onBoardingTitle3': 'Entrega a domicilio',
        'onBoardingSubTitle3': '¡Entrega rápida, segura y sin contacto!',
        'other': '',
      },
    );
    return temp0;
  }

  @override
  String login(String name) {
    String temp0 = intl.Intl.selectLogic(
      name,
      {
        'loginEmail': 'Correo electrónico',
        'loginPassword': 'Contraseña',
        'loginSignIn': 'Iniciar sesión',
        'other': '',
      },
    );
    return temp0;
  }
}
