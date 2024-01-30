import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/standard_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:flutter_custom_tab_bar/transform/scale_transform.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:hello_teacher_admin_dashboard/app/modules/image_carousel/views/image_carousel_view.dart';
import 'package:hello_teacher_admin_dashboard/constants.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  final int pageCount = 2;
  late PageController _controller = PageController(initialPage: 0);
  CustomTabBarController _tabBarController = CustomTabBarController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
        height: 720,
        child: Column(children: [
          CustomTabBar(
            tabBarController: _tabBarController,
            height: 35,
            itemCount: pageCount,
            builder: getTabbarChild,
            indicator: StandardIndicator(
              width: 20,
              height: 3,
              color: Colors.green,
            ),
            pageController: _controller,
          ),
          Expanded(
              child: PageView.builder(
                  controller: _controller,
                  itemCount: pageCount,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return controller.obx(
                          (settings) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: const EdgeInsets.all(defaultPadding),
                              decoration: const BoxDecoration(
                                color: secondaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  const Text('Settings'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FormBuilder(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        FormBuilderTextField(
                                          name: 'percentageTaken',
                                          initialValue:
                                              settings?.percentage.toString() ??
                                                  '0',
                                          decoration: const InputDecoration(
                                            labelText: 'Percentage Taken',
                                            suffix: Icon(Icons.percent),
                                          ),
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.numeric(),
                                            FormBuilderValidators.max(100),
                                            FormBuilderValidators.required(),
                                          ]),
                                        ),
                                        FormBuilderTextField(
                                          name: 'tax',
                                          decoration: const InputDecoration(
                                              labelText: 'Tax',
                                              suffix: Icon(Icons.percent)),
                                          initialValue:
                                              settings?.tax.toString() ?? '0',
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.numeric(),
                                            FormBuilderValidators.required(),
                                          ]),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          '* the percentage that will be deducted when the teacher makes a withdrawal',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .saveAndValidate()) {
                                              final Map<String, dynamic>
                                                  formData =
                                                  formKey.currentState!.value;
                                              final int percentageTaken =
                                                  int.parse(formData[
                                                      'percentageTaken']);
                                              final int tax =
                                                  int.parse(formData['tax']);
                                              Get.defaultDialog(
                                                  title: 'Submit Settings',
                                                  content: const Text(
                                                    'Are you sure you wanto save the current setting, it will affect teacher withdrawal percentage and tax',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  onConfirm: () {
                                                    controller.saveSettings(
                                                        percentageTaken, tax);
                                                  },
                                                  textConfirm: 'Save Settings');
                                            }
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          onLoading: const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      case 1:
                        return ImageCarouselView();
                      default:
                    }
                  }))
        ]));
  }

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
      index: index,
      transform: ScaleTransform(
        maxScale: 1.3,
        transform: ColorsTransform(
          normalColor: Colors.white54,
          highlightColor: Colors.white,
          builder: (context, color) {
            return Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: 100),
              child: (Text(
                controller.tabBarTitle[index],
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}
