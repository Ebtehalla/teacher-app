import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:hello_teacher_admin_dashboard/app/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  //final AuthService _authServices = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
