import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:halo_teacher/app/routes/app_pages.dart';
import 'package:halo_teacher/app/utils/search/search_teacher_delegate.dart';

import '../controllers/search_teacher_controller.dart';

class SearchTeacherView extends GetView<SearchTeacherController> {
  const SearchTeacherView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Teacher'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                controller.teacher.value = (await showSearch(
                  context: context,
                  delegate: SearchTeacherDelegate(),
                ))!;
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: Obx(
          () => Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: controller.teacher.value.name == null
                ? Center(
                    child: Text(
                      'Search Teacher'.tr,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView(children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_TEACHER,
                              arguments: controller.teacher.value);
                        },
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              controller.teacher.value.picture!),
                        ),
                        title: Text(controller.teacher.value.name!),
                        trailing: RatingBarIndicator(
                            rating: 4.5,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )),
                      ),
                    ),
                  ]),
          ),
        ));
  }
}
