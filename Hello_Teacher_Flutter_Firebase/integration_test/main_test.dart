import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/utils/environment.dart';
import 'package:halo_teacher/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:patrol/patrol.dart';

///Integration Test using Patrol Test, why using patroll instead of flutter integration test? because default flutter test doesn't
///support native test, like clicking on allow notification but with patroll you can do all of the native test
///for more information go to patroll documentation https://patrol.leancode.co/
///These test are just example test just to make sure the app is working, you are open to create your own test
///To run the test using patrol use this command, but make sure you have install the patroll cli, follow the documentation https://patrol.leancode.co/
///Command : patrol test -t integration_test/main_test.dart
void main() {
  //Replace these values with your own
  String clientEmail = 'test11@gmail.com';
  String clientPassowrd = 'test11';
  setUp(() async {
    await dotenv.load();
    await Firebase.initializeApp();
    NotificationService();
    Stripe.publishableKey = Environment.stripePublishableKey;
    initializeDateFormatting('en', null);
    FirebaseChatCore.instance
        .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  });
  patrolTest('Login Test', ($) async {
    await $.pumpWidgetAndSettle(HaloTeacherApp(isUserLogin: false));
    await $(#username).enterText(clientEmail);
    await $(#password).enterText(clientPassowrd);
    await $.tester.testTextInput.receiveAction(TextInputAction.done);
    await $(#loginButton).tap(settlePolicy: SettlePolicy.noSettle);
    // await $("Welcome Back,").waitUntilExists();
    // if (await $.native
    //     .isPermissionDialogVisible(timeout: Duration(seconds: 10))) {
    //   // await $.native.grantPermissionWhenInUse();
    //   print('notification permission pop up');
    //   await $.native.tap(
    //     Selector(text: 'Allow'),
    //   );
    // }

    // /// click on bottom navigation bar to go
    // await $(#doctorCategoryIcon).tap();
    // await $(#appointmentIcon).tap();
    // await $(#chatIcon).tap();
    // await $(#profileIcon).tap();
  });

  // testWidgets('Main Test', (WidgetTester tester) async {
  //   // Run app
  //   await tester
  //       .pumpWidget(HaloTeacherApp(isUserLogin: false)); // Create main app
  //   await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
  //   await tester.pump(Duration(seconds: 2)); // Wait some time

  //   // Find username & password text
  //   final Finder usernameText = find.byKey(ValueKey('username'));
  //   final Finder passwordText = find.byKey(ValueKey('password'));

  //   // Ensure there is a login and password field on the initial page
  //   expect(usernameText, findsOneWidget);
  //   expect(passwordText, findsOneWidget);

  //   // Enter text
  //   await tester.enterText(usernameText, 'test11@gmail.com');
  //   await tester.enterText(passwordText, 'test11');
  //   await tester.pumpAndSettle();
  //   await tester.pump(Duration(seconds: 10));

  //   // Find login button
  //   final Finder loginButton = find.byKey(ValueKey('loginButton'));
  //   // Tap login button
  //   await tester.tap(loginButton, warnIfMissed: true);
  //   await tester.pumpAndSettle();
  //   await tester.pump(Duration(seconds: 2));

  //   //find test button
  //   expect(find.byKey(ValueKey('testButton')), findsNothing);
  // });
}
