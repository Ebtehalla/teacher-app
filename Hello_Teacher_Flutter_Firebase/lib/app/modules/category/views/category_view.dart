import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.mBackgroundColor,
        elevation: 0,
        title: Text(
          'Category'.tr,
          style: TextStyle(color: Styles.mTitleColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: controller.obx((listCategory) => GridView.builder(
                  itemCount: listCategory!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.LIST_TEACHER,
                            arguments: listCategory[index]);
                      },
                      child: Container(
                          child: Column(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Styles.lightPrimaryColor),
                            padding: const EdgeInsets.all(8.0),
                            child: listCategory[index].iconUrl != null
                                ? Image.network(listCategory[index].iconUrl!)
                                : Image.asset('assets/icons/application.png'),
                          )),
                          SizedBox(
                            height: 5,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              listCategory[index].categoryName!,
                              style: Styles().teacherCategoryTextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          )
                        ],
                      )),
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
