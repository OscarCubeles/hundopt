import 'package:hundopt/modules/auth/auth.dart';
import 'package:hundopt/modules/home/home.dart';
import 'package:hundopt/modules/modules.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: Routes.AUTH,
      page: () => AuthScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      children: [
        GetPage(name: Routes.REGISTER, page: () => RegisterScreen(), transition: Transition.fadeIn),
        GetPage(name: Routes.LOGIN, page: () => LoginScreen(), transition: Transition.fadeIn),
        GetPage(name: Routes.FORGOT_PASSWORD, page: () => ForgotPassword(), transition: Transition.fadeIn)

      ],
    ),
    GetPage(
        name: Routes.HOME,
        page: () => HomeScreen(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        children: [
          //GetPage(name: Routes.CARDS, page: () => CardsScreen()),
        ]),
  ];
}