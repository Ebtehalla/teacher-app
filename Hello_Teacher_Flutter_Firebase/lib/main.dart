import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:halo_teacher/app/services/local_notification_service.dart';
// ignore: unused_import
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/utils/environment.dart';
import 'package:halo_teacher/app/utils/localization.dart';
import 'app/routes/app_pages.dart';
import 'app/services/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/utils/styles/styles.dart';

//Main Appi
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  await GetStorage.init();
  LocalNotificationService().initNotification();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  Stripe.publishableKey = Environment.stripePublishableKey;
  initializeDateFormatting('en', null);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  FirebaseChatCore.instance
      .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  runApp(HaloTeacherApp(isUserLogin: isUserLogin));
}

class HaloTeacherApp extends StatelessWidget {
  HaloTeacherApp({super.key, required this.isUserLogin});
  final bool isUserLogin;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL_ROUTE,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      locale: LocalizationService.locale,
      translations: LocalizationService(),
      theme: ThemeData(primaryColor: Styles.primaryColor, useMaterial3: true),
    );
  }
}
