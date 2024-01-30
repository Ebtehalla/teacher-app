import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/modules/list_teacher/views/widgets/text_with_icon.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard(
      {Key? key,
      required this.teacherPhotoUrl,
      required this.teacherName,
      required this.education,
      required this.basePrice,
      required this.category,
      required this.onTap})
      : super(key: key);

  final String teacherPhotoUrl;
  final String teacherName;
  final String education;
  final String basePrice;
  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: IntrinsicHeight(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(teacherPhotoUrl)),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Price'.tr,
                      style: Styles().priceTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      basePrice,
                      style: Styles().priceNumberTextStyle,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                teacherName,
                                style: Styles().teacherNameStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextWithIcon(
                            text: category,
                            imageAsset: 'assets/icons/category.png',
                          ),
                          SizedBox(height: 5),
                          TextWithIcon(
                            text: education,
                            imageAsset: 'assets/icons/education.png',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBarIndicator(
                              rating: 4.5,
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Styles.primaryColor),
                        child: Text(
                          'Book Consultation'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
