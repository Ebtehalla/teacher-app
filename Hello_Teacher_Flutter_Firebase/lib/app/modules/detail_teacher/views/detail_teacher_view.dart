import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/detail_teacher/views/widgets/review_card.dart';

import 'package:halo_teacher/app/utils/constants/constants.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/detail_teacher_controller.dart';

class DetailTeacherView extends GetView<DetailTeacherController> {
  const DetailTeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher".tr),
        centerTitle: true,
      ),
      body: Stack(children: [
        controller.obx((teacher) => Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  buildImage(Styles.lightPrimaryColor,
                      teacherProfilePic: teacher!.picture!),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    teacher.name!,
                    style: Styles().teacherNameStyle,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    teacher.category!.categoryName!,
                    style: Styles().teacherCategoryStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBarIndicator(
                      rating: 4.5,
                      itemCount: 5,
                      itemSize: 20.0,
                      itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Biography'.tr,
                      style: Styles().titleTextStyle,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    teacher.shortBiography!,
                    style: Styles().subTitleTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Review'.tr,
                        style: Styles().titleTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('View All'.tr),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: GetBuilder<DetailTeacherController>(
                      builder: (_) {
                        return ListView.builder(
                            itemCount: _.listReview.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ReviewCard(review: _.listReview[index]);
                            });
                      },
                    ),
                  )
                ]),
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 2, 10, 2),
            decoration: BoxDecoration(
              color: Styles.mBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: controller.selectedTeacher.basePrice != null
                      ? Text(
                          currencySign +
                              ' ' +
                              controller.selectedTeacher.basePrice!.toString(),
                          style: Styles().priceNumberTextStyle,
                        )
                      : Text(
                          currencySign + ' 0',
                          style: Styles().priceNumberTextStyle,
                        ),
                  flex: 2,
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 3, 10),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed('/consultation-date-picker',
                              arguments: [controller.selectedTeacher, null]);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Styles.lightPrimaryColor,
                          ),
                          child: Text(
                            'Book Consultation'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => controller.toChatTeacher(),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Styles.lightPrimaryColor,
                    ),
                    child: Icon(
                      Icons.message_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Builds Profile Image
Widget buildImage(Color color, {String teacherProfilePic = ''}) {
  final defaultImage = teacherProfilePic.isEmpty
      ? AssetImage('assets/images/user.png')
      : NetworkImage(teacherProfilePic);

  return Container(
    child: CircleAvatar(
      radius: 53,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: defaultImage as ImageProvider,
        radius: 50,
      ),
    ),
  );
}
