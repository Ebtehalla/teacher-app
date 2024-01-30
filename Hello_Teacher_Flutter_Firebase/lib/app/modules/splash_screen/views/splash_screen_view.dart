import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/modules/dashboard/views/dashboard_view.dart';
import 'package:halo_teacher/app/modules/login/views/login_view.dart';
import 'package:halo_teacher/app/modules/teacher_dashboard/views/teacher_dashboard_view.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/services/firebase_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: FirebaseService().checkUserAlreadyLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // handle the error
          return Center(
            child: Text('An error occurred: ${snapshot.error}'),
          );
        } else if (snapshot.data == true) {
          // user is logged in, fetch user data and navigate to their dashboard based on their role
          return FutureBuilder<UserModel?>(
            future: UserService().getUserModel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // handle the error
                return Center(
                  child: Text('An error occurred: ${snapshot.error}'),
                );
              } else {
                // user data fetched successfully, navigate to their dashboard based on their role
                final role = snapshot.data!.role;

                if (role == Roles.teacher) {
                  print('role teacher');
                  Future.delayed(Duration(milliseconds: 500), () {
                    Get.offAllNamed(Routes.TEACHER_DASHBOARD);
                  });
                  return Container();
                } else {
                  print('role user');
                  Future.delayed(Duration(milliseconds: 500), () {
                    Get.offAllNamed(Routes.DASHBOARD);
                  });
                  return Container();
                }
              }
            },
          );
        } else {
          // user is not logged in, navigate to the login page
          Future.delayed(Duration(milliseconds: 500), () {
            Get.offAllNamed(Routes.LOGIN);
          });
          return Container();
        }
      },
    );
  }
}
