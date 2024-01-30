import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halo_teacher/app/modules/teacher_withdraw_method/views/pages/add_paypal_page.dart';
import 'package:halo_teacher/app/modules/teacher_withdraw_method/views/widgets/withdraw_method_tile.dart';
import 'package:halo_teacher/app/utils/styles/styles.dart';

import '../controllers/teacher_withdraw_method_controller.dart';

class TeacherWithdrawMethodView
    extends GetView<TeacherWithdrawMethodController> {
  const TeacherWithdrawMethodView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withdraw Method'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.blue[400]),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Chose Withdraw Provider".tr,
                  content: Container(
                    width: 250,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Get.off(() => AddPaypalPage());
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Styles.whiteGreyColor,
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/paypal_logo.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Paypal",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        child: controller.obx(
          (listWithdrawMethod) => ListView.builder(
            shrinkWrap: true,
            itemCount: listWithdrawMethod!.length,
            itemBuilder: (contex, index) => WithdrawMethodTile(
              name: listWithdrawMethod[index].name!,
              email: listWithdrawMethod[index].email!,
              onTap: () =>
                  controller.toWithdrawDetail(listWithdrawMethod[index]),
            ),
          ),
          onEmpty: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                'you don\'t have a withdrawal method, please add one, to withdraw your money'
                    .tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
