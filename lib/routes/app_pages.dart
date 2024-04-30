import 'package:get/get.dart';
import 'package:kabadi_app/view/welcome_screen/welcome_view.dart';

import '../view/add_new_address/add_new_address_controller.dart';
import '../view/add_new_address/add_new_address_view.dart';
import '../view/choose_language/choose_language_view.dart';
import '../view/edit_profile_screen/edit_profile_view.dart';
import '../view/enter_name_screen/enter_name_view.dart';
import '../view/login_screen/login_view.dart';
import '../view/my_pickup_requests/my_pickup_view.dart';
import '../view/otp_screen/otp_view.dart';
import '../view/profile_screen/profile_view.dart';
import '../view/request_cancelled/request_cancelled_view.dart';
import '../view/reschedule_screen/reschedule_view.dart';
import '../view/sell_scrap/sellscrap_view.dart';
import '../view/sell_scrap_item/sell_scrap_item_view.dart';
import '../view/signup_screen/signup_view.dart';
import '../view/splash_screen/splash_view.dart';
import '../view/track_pickup_request/track_pickup_view.dart';
part 'app_routes.dart';


class AppPages {
  static const INITIAL = Routes.splashView;

  static final routes = [
    GetPage(
      name: Routes.splashView,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.loginView,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Routes.welcomeView,
      page: () =>  const WelcomeView(),
    ),
    GetPage(
      name: Routes.otpView,
      page: () =>  const OtpView(),
    ),
    GetPage(
      name: Routes.chooseLanguageView,
      page: () => const ChooseLanguageView(),
    ),
    GetPage(
      name: Routes.enterNameView,
      page: () => const EnterNameView(),
    ),
    GetPage(
      name: Routes.sellScrapItemView,
      page: () =>  SellScrapItemView(),
    ),
    GetPage(
      name: Routes.myPickupView,
      page: () => const MyPickupView(),
    ),
    GetPage(
      name: Routes.sellScrapView,
      page: () => const SellScrapView(),
    ),
    GetPage(
      name: Routes.profileView,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Routes.editProfileView,
      page: () => const EditProfileView(),
    ),
    GetPage(
      name: Routes.trackPickupView,
      page: () =>  TrackPickupView(),
    ),
    GetPage(
      name: Routes.requestCancelledView,
      page: () =>  const RequestCancelledView(),
    ),GetPage(
      name: Routes.rescheduleView,
      page: () =>  const RescheduleView(),
    ),GetPage(
      name: Routes.signupView,
      page: () =>  const SignupView(),
    ),GetPage(
      name: Routes.addNewAddressView,
      page: () =>  const AddNewAddressView(),
      binding: AddNewAddressBinding(),
    ),

  ];
}
class AddNewAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewAddressController());
  }
}