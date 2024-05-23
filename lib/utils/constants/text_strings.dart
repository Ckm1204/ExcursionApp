import 'package:excursion/generated/app_localizations.dart';
import 'package:get/get.dart';

class AppText {
  AppText._();

  // Global texts

  // Login texts
  static String email = AppLocalizations.of(Get.context!).login('email');
  static String password = AppLocalizations.of(Get.context!).login('password');
  static String login = AppLocalizations.of(Get.context!).login('login');
  static String userLogin = AppLocalizations.of(Get.context!).login('userLogin');
  static String someError = AppLocalizations.of(Get.context!).login('someError');
  static String userNotFound = AppLocalizations.of(Get.context!).login('userNotFound');
  static String wrongPassword = AppLocalizations.of(Get.context!).login('wrongPassword');
  static String loginGoogle = AppLocalizations.of(Get.context!).login('loginGoogle');
  static String dontHaveAcc = AppLocalizations.of(Get.context!).login('dontHaveAcc');
  static String signUp = AppLocalizations.of(Get.context!).login('signUp');
  static String alHaveAcc = AppLocalizations.of(Get.context!).login('alHaveAcc');
  static String username = AppLocalizations.of(Get.context!).login('username');

// Nav Bar

static String home = AppLocalizations.of(Get.context!).nav_bar('home');
static String search = AppLocalizations.of(Get.context!).nav_bar('search');
static String profile = AppLocalizations.of(Get.context!).nav_bar('profile');



}
