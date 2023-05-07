import 'package:hundopt/modules/auth/auth.dart';
import 'package:hundopt/modules/dog_info/dog_info.dart';
import 'package:hundopt/modules/home/home.dart';
import 'package:hundopt/modules/individual_chat/individual_chat.dart';
import 'package:hundopt/modules/modules.dart';
import 'package:get/get.dart';
import 'package:hundopt/modules/onboarding/onboarding.dart';
import 'package:hundopt/modules/settings/settings.dart';

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
        GetPage(
            name: Routes.REGISTER,
            page: () => RegisterScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: Routes.LOGIN,
            page: () => LoginScreen(),
            transition: Transition.fadeIn),
        GetPage(
            name: Routes.FORGOT_PASSWORD,
            page: () => ForgotPassword(),
            transition: Transition.fadeIn)
      ],
    ),
    // TODO: Posar les pagines de explore, chat, favourite and settings com a children de les de home
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
        children: []),
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsScreen(),
        binding: SettingsBinding(),
        transition: Transition.fadeIn,
        children: [
          GetPage(
              name: Routes.EDIT_PROFILE,
              page: () => const EditProfileScreen(),
              transition: Transition.fadeIn)
        ]),
    GetPage(
        name: Routes.PERSONALITY_FORM,
        binding: FormBinding(),
        page: () => const PersonalityFormScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: Routes.ONBOARDING,
        binding: OnboardingBinding(),
        transition: Transition.fadeIn,
        page: () => OnboardingScreen()),
    GetPage(
        name: Routes.DOG_INFO,
        binding: DogInfoBinding(),
        transition: Transition.fadeIn,
        page: () => DogInfoScreen(),
      children: [
        GetPage(
            name: Routes.RESERVED_DOG,
            page: () => DogReservedScreen(),
            transition: Transition.fadeIn),
      ]
    ),
    GetPage(
        name: Routes.INDIVIDUAL_CHAT,
        binding: IndividualChatBinding(),
        transition: Transition.fadeIn,
        page: () => IndividualChatScreen()),
  ];
}
