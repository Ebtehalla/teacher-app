import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white, width: 2), // Border around the form
              borderRadius:
                  BorderRadius.circular(10), // Rounded corners for the border
              color:
                  Colors.lightBlue[600], // Background color inside the border
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 75,
                      width: 75,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Admin Panel',
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        // Other style properties here
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: 300.0,
                      child: FormBuilderTextField(
                        cursorColor: Colors.white,
                        name: 'email',
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            prefixIconColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors
                                    .white, // Customize the focused border color here
                              ),
                            )),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 300.0,
                      child: FormBuilderTextField(
                        cursorColor: Colors.white,
                        name: 'password',
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: Colors.white,
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .white, // Customize the focused border color here
                            ))),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: 300.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.loginFormKey.currentState!
                              .saveAndValidate()) {
                            controller.login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
