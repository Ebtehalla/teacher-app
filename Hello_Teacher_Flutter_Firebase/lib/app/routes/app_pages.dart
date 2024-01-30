import 'package:get/get.dart';

import '../modules/add_teacher_detail/bindings/add_teacher_detail_binding.dart';
import '../modules/add_teacher_detail/views/add_teacher_detail_view.dart';
import '../modules/add_timeslot/bindings/add_timeslot_binding.dart';
import '../modules/add_timeslot/views/add_timeslot_view.dart';
import '../modules/appointment/bindings/appointment_binding.dart';
import '../modules/appointment/views/appointment_view.dart';
import '../modules/appointment_detail/bindings/appointment_detail_binding.dart';
import '../modules/appointment_detail/views/appointment_detail_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/consultation_confirm/bindings/consultation_confirm_binding.dart';
import '../modules/consultation_confirm/views/consultation_confirm_view.dart';
import '../modules/consultation_date_picker/bindings/consultation_date_picker_binding.dart';
import '../modules/consultation_date_picker/views/consultation_date_picker_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/delete_account/bindings/delete_account_binding.dart';
import '../modules/delete_account/views/delete_account_view.dart';
import '../modules/detail_order/bindings/detail_order_binding.dart';
import '../modules/detail_order/views/detail_order_view.dart';
import '../modules/detail_teacher/bindings/detail_teacher_binding.dart';
import '../modules/detail_teacher/views/detail_teacher_view.dart';
import '../modules/edit_image/bindings/edit_image_binding.dart';
import '../modules/edit_image/views/edit_image_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_chat/bindings/list_chat_binding.dart';
import '../modules/list_chat/views/list_chat_view.dart';
import '../modules/list_teacher/bindings/list_teacher_binding.dart';
import '../modules/list_teacher/views/list_teacher_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/payment_success/bindings/payment_success_binding.dart';
import '../modules/payment_success/views/payment_success_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/review/bindings/review_binding.dart';
import '../modules/review/views/review_view.dart';
import '../modules/search_teacher/bindings/search_teacher_binding.dart';
import '../modules/search_teacher/views/search_teacher_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/teacher_appointment/bindings/teacher_appointment_binding.dart';
import '../modules/teacher_appointment/views/teacher_appointment_view.dart';
import '../modules/teacher_balance/bindings/teacher_balance_binding.dart';
import '../modules/teacher_balance/views/teacher_balance_view.dart';
import '../modules/teacher_calendar/bindings/teacher_calendar_binding.dart';
import '../modules/teacher_calendar/views/teacher_calendar_view.dart';
import '../modules/teacher_dashboard/bindings/teacher_dashboard_binding.dart';
import '../modules/teacher_dashboard/views/teacher_dashboard_view.dart';
import '../modules/teacher_delete_account/bindings/teacher_delete_account_binding.dart';
import '../modules/teacher_delete_account/views/teacher_delete_account_view.dart';
import '../modules/teacher_detail_order/bindings/teacher_detail_order_binding.dart';
import '../modules/teacher_detail_order/views/teacher_detail_order_view.dart';
import '../modules/teacher_edit_profile/bindings/teacher_edit_profile_binding.dart';
import '../modules/teacher_edit_profile/views/teacher_edit_profile_view.dart';
import '../modules/teacher_home/bindings/teacher_home_binding.dart';
import '../modules/teacher_home/views/teacher_home_view.dart';
import '../modules/teacher_list_chat/bindings/teacher_list_chat_binding.dart';
import '../modules/teacher_list_chat/views/teacher_list_chat_view.dart';
import '../modules/teacher_login/bindings/teacher_login_binding.dart';
import '../modules/teacher_login/views/teacher_login_view.dart';
import '../modules/teacher_profile/bindings/teacher_profile_binding.dart';
import '../modules/teacher_profile/views/teacher_profile_view.dart';
import '../modules/teacher_register/bindings/teacher_register_binding.dart';
import '../modules/teacher_register/views/teacher_register_view.dart';
import '../modules/teacher_withdraw_detail/bindings/teacher_withdraw_detail_binding.dart';
import '../modules/teacher_withdraw_detail/views/teacher_withdraw_detail_view.dart';
import '../modules/teacher_withdraw_finish/bindings/teacher_withdraw_finish_binding.dart';
import '../modules/teacher_withdraw_finish/views/teacher_withdraw_finish_view.dart';
import '../modules/teacher_withdraw_method/bindings/teacher_withdraw_method_binding.dart';
import '../modules/teacher_withdraw_method/views/teacher_withdraw_method_view.dart';
import '../modules/top_rated_teacher/bindings/top_rated_teacher_binding.dart';
import '../modules/top_rated_teacher/views/top_rated_teacher_view.dart';
import '../modules/video_call/bindings/video_call_binding.dart';
import '../modules/video_call/views/video_call_view.dart';
import '../modules/withdraw_finish/bindings/withdraw_finish_binding.dart';
import '../modules/withdraw_finish/views/withdraw_finish_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const DASHBOARD = Routes.DASHBOARD;
  static const LOGIN = Routes.LOGIN;
  static const INITIAL_ROUTE = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_DATE_PICKER,
      page: () => ConsultationDatePickerView(),
      binding: ConsultationDatePickerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER,
      page: () => DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_SUCCESS,
      page: () => PaymentSuccessView(),
      binding: PaymentSuccessBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT,
      page: () => AppointmentView(),
      binding: AppointmentBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENT_DETAIL,
      page: () => AppointmentDetailView(),
      binding: AppointmentDetailBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW,
      page: () => ReviewView(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CONSULTATION_CONFIRM,
      page: () => ConsultationConfirmView(),
      binding: ConsultationConfirmBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => ListChatView(),
      binding: ListChatBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.DELETE_ACCOUNT,
      page: () => const DeleteAccountView(),
      binding: DeleteAccountBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_DASHBOARD,
      page: () => TeacherDashboardView(),
      binding: TeacherDashboardBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      binding: TeacherHomeBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_LOGIN,
      page: () => const TeacherLoginView(),
      binding: TeacherLoginBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_REGISTER,
      page: () => const TeacherRegisterView(),
      binding: TeacherRegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TEACHER_DETAIL,
      page: () => const AddTeacherDetailView(),
      binding: AddTeacherDetailBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_CALENDAR,
      page: () => TeacherCalendarView(),
      binding: TeacherCalendarBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_APPOINTMENT,
      page: () => const TeacherAppointmentView(),
      binding: TeacherAppointmentBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_LIST_CHAT,
      page: () => const TeacherListChatView(),
      binding: TeacherListChatBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_PROFILE,
      page: () => const TeacherProfileView(),
      binding: TeacherProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TIMESLOT,
      page: () => AddTimeslotView(),
      binding: AddTimeslotBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_EDIT_PROFILE,
      page: () => const TeacherEditProfileView(),
      binding: TeacherEditProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_IMAGE,
      page: () => const EditImageView(),
      binding: EditImageBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_DELETE_ACCOUNT,
      page: () => const TeacherDeleteAccountView(),
      binding: TeacherDeleteAccountBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_BALANCE,
      page: () => const TeacherBalanceView(),
      binding: TeacherBalanceBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_WITHDRAW_METHOD,
      page: () => const TeacherWithdrawMethodView(),
      binding: TeacherWithdrawMethodBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_WITHDRAW_DETAIL,
      page: () => const TeacherWithdrawDetailView(),
      binding: TeacherWithdrawDetailBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_WITHDRAW_FINISH,
      page: () => const TeacherWithdrawFinishView(),
      binding: TeacherWithdrawFinishBinding(),
    ),
    GetPage(
      name: _Paths.LIST_TEACHER,
      page: () => const ListTeacherView(),
      binding: ListTeacherBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER_DETAIL_ORDER,
      page: () => const TeacherDetailOrderView(),
      binding: TeacherDetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.WITHDRAW_FINISH,
      page: () => const WithdrawFinishView(),
      binding: WithdrawFinishBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_TEACHER,
      page: () => const DetailTeacherView(),
      binding: DetailTeacherBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.TOP_RATED_TEACHER,
      page: () => const TopRatedTeacherView(),
      binding: TopRatedTeacherBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_TEACHER,
      page: () => const SearchTeacherView(),
      binding: SearchTeacherBinding(),
    ),
  ];
}
