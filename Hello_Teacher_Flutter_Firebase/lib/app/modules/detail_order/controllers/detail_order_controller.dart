import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/order_detail_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/modules/profile/controllers/profile_controller.dart';
import 'package:halo_teacher/app/services/local_notification_service.dart';
import 'package:halo_teacher/app/services/notification_service.dart';
import 'package:halo_teacher/app/services/payment_service.dart';
import 'package:halo_teacher/app/services/user_service.dart';
import 'package:halo_teacher/app/utils/constants/constants.dart';
import 'package:intl/intl.dart';

class DetailOrderController extends GetxController {
  final username = ''.obs;
  final UserService userService = Get.find();
  List<OrderDetailModel> orderDetail = List.empty();
  TimeSlot selectedTimeSlot = Get.arguments[0];
  Teacher teacher = Get.arguments[1];
  PaymentService paymentService = Get.find();
  NotificationService notificationService = Get.find<NotificationService>();
  late String clientSecret;
  @override
  void onInit() {
    super.onInit();
    userService.getUsername().then((value) {
      username.value = value;
    });
  }

  @override
  void onClose() {}

  OrderDetailModel buildOrderDetail() {
    var formatter = DateFormat('yyyy-MM-dd hh:mm');
    var time = formatter.format(selectedTimeSlot.timeSlot!);

    var orderDetail = OrderDetailModel(
        itemId: selectedTimeSlot.id!,
        itemName: 'Consultation with ${teacher.name!}',
        time: time,
        duration: '${selectedTimeSlot.duration} minute',
        price: currencySign + selectedTimeSlot.price.toString());
    return orderDetail;
  }

  /// by default the payment method we us is Stripe to change you need to change
  /// makePayment method and change the cloud function method
  void payWithStripe() async {
    EasyLoading.show();
    try {
      var clientSecret = await paymentService.getClientSecret(
          selectedTimeSlot.id!, userService.getUserId());
      if (clientSecret.isEmpty) return;

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: appName,
        paymentIntentClientSecret: clientSecret,
      ));
      EasyLoading.dismiss();
      await Stripe.instance.presentPaymentSheet();

      Get.offNamed('/payment-success', arguments: selectedTimeSlot);
      //TODO implement notification
      await LocalNotificationService().setAppointmentNotification(
          teacher: teacher, timeSlot: selectedTimeSlot);
    } on StripeException catch (err) {
      Fluttertoast.showToast(msg: err.error.message!);
      return null;
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {
      EasyLoading.dismiss();
    }
  }

  void purchaseFreeTimeslot() async {
//check the price if 0 call cloud function to check if this timeslot is actually 0
    //then return true, if false then throw error

    try {
      EasyLoading.show();
      bool result = await PaymentService()
          .purchaseFreeTimeSlot(selectedTimeSlot.id!, userService.getUserId());
      if (result) {
        Get.offNamed('/payment-success', arguments: selectedTimeSlot);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void makePayment() async {
    if (selectedTimeSlot.price! <= 0) {
      print('purchase free timeslot : ');
      purchaseFreeTimeslot();
    } else {
      print('purchase stripe');
      payWithStripe();
    }
  }
}
