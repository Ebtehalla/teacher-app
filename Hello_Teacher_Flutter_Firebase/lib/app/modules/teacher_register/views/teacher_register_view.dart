import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/login/views/widgets/label_button.dart';
import 'package:halo_teacher/app/modules/widgets/submit_button.dart';
import 'package:halo_teacher/app/modules/widgets/teacher_title_app.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/utils/helpers/validation.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_register_controller.dart';

class TeacherRegisterView extends GetView<TeacherRegisterController> {
  const TeacherRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: FormBuilder(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    TeacherTitleApp(),
                    SizedBox(
                      height: 50,
                    ),
                    FormBuilderTextField(
                      key: Key('username'),
                      name: 'username',
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        node.nextFocus();
                      },
                      validator: FormBuilderValidators.min(4,
                          errorText: 'Name must be more than four characters'),
                      onSaved: (username) {
                        controller.username = username!;
                      },
                      decoration: InputDecoration(
                          hintText: 'Username'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FormBuilderTextField(
                      key: Key('email'),
                      name: 'email',
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        node.nextFocus();
                      },
                      validator: FormBuilderValidators.email(),
                      onSaved: (email) {
                        controller.email = email!;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email'.tr,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          fillColor: Colors.grey[200],
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<TeacherRegisterController>(
                        builder: (controller) => FormBuilderTextField(
                              key: Key('password'),
                              name: 'password',
                              obscureText: controller.passwordVisible,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                node.nextFocus();
                              },
                              validator: FormBuilderValidators.min(6,
                                  errorText:
                                      'Password must be more than six characters'
                                          .tr),
                              onSaved: (password) {
                                controller.password = password!;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Password'.tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      )),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        controller.passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Styles.primaryColor),
                                    onPressed: () {
                                      controller.passwordIconVisibility();
                                    },
                                  )),
                            )),
                    SizedBox(
                      height: 20,
                    ),
                    SubmitButton(
                        onTap: () {
                          controller.signUpUser();
                        },
                        text: 'Register Now'.tr),
                    SizedBox(height: height * .01),
                    Divider(),
                    LabelButton(
                      onTap: () {
                        Get.offAndToNamed(Routes.TEACHER_LOGIN);
                      },
                      title: 'Already have a Teacher account ?'.tr,
                      subTitle: 'Login Teacher'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: BackButton()),
        ],
      ),
    );
  }
}
