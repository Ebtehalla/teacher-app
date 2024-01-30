import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/services/firebase_service.dart';
import 'package:halo_teacher/app/services/google_signin_api.dart';
import 'package:halo_teacher/app/services/local_notification_service.dart';
import 'package:halo_teacher/app/services/teacher_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:halo_teacher/app/utils/helpers/converter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginGoogle(Roles userRole) async {
    try {
      //Google Api  Login
      final googleUser = await GoogleSignInApi.login();
      GoogleSignInAuthentication authentication =
          await googleUser!.authentication;
      var credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;
      if (userRole == Roles.user) {
      } else if (userRole == Roles.teacher) {
        await FirebaseService()
            .userTeacherSetup(user!, user.displayName!, userRole);
      }
    } on FirebaseAuthException catch (err) {
      return Future.error(err.message!);
    }
  }

  Future<User> signInWithApple(Roles userRole) async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = Converter().sha256ofString(rawNonce);

    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      print(appleCredential.authorizationCode);

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final authResult = await _auth.signInWithCredential(oauthCredential);

      final displayName =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';

      final firebaseUser = authResult.user;
      if (appleCredential.givenName != null) {
        await firebaseUser!.updateDisplayName(displayName);
        await firebaseUser.updateEmail(userEmail);
        if (userRole == Roles.user) {
        } else if (userRole == Roles.teacher) {
          await FirebaseService()
              .userTeacherSetup(firebaseUser, displayName, userRole);
        }
      }
      return firebaseUser!;
    } catch (exception) {
      print(exception);
      return Future.error(exception);
    }
  }

  Future login(String username, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: username, password: password);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<void> logout() async {
    try {
      await LocalNotificationService().removeToken();
      TeacherService.setCurrentTeacher(null);
      _auth.signOut();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future register(
      String username, String email, String password, Roles userRole) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserService().currentUserFirebase = result.user;
      await UserService().currentUserFirebase!.updateDisplayName(username);
      if (userRole == Roles.user) {
        await FirebaseService().userSetup(result.user!, username, userRole);
      } else if (userRole == Roles.teacher) {
        await FirebaseService()
            .userTeacherSetup(result.user!, username, userRole);
      }
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    } on SocketException catch (e) {
      return Future.error(e.message);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.message!);
    }
  }

  /// for checking user password, ex change password, withdraw balance need passsword
  Future<bool> verifyPassword(String password) async {
    try {
      var firebaseUser = _auth.currentUser!;
      var authCredential = EmailAuthProvider.credential(
          email: firebaseUser.email!, password: password);
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredential);
      return authResult.user != null;
    } catch (e) {
      return false;
    }
  }

  ///check whether user is already set his the teacher detail or not
  ///return boolean true if user set his teacher detail
  Future<bool> checkTeacherDetail() async {
    try {
      String? teacherId = await UserService().getTeacherId();
      if (teacherId != null) return true;
      return false;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
