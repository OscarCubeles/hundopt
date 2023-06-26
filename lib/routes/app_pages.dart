import 'package:hundopt/modules/modules.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// The [AppPages] class defines the routes and pages of the app.
class AppPages {
  /// The initial route of the app.
  static const INITIAL = Routes.SPLASH;

  /// A list of [GetPage] objects that define the pages of the app.
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const AuthScreen(),
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
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: Routes.SETTINGS,
        page: () => const SettingsScreen(),
        binding: SettingsBinding(),
        transition: Transition.fadeIn,
        children: [
          GetPage(
              name: Routes.EDIT_PROFILE,
              page: () => const EditProfileScreen(),
              transition: Transition.fadeIn),
          GetPage(
              name: Routes.ADOPT_STEPS,
              page: () => const AdoptStepsScreen(),
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
        page: () => const OnboardingScreen()),
    GetPage(
        name: Routes.DOG_INFO,
        binding: DogInfoBinding(),
        transition: Transition.fadeIn,
        page: () => const DogInfoScreen(),
        children: [
          GetPage(
              name: Routes.RESERVED_DOG,
              page: () => const DogReservedScreen(),
              transition: Transition.fadeIn),
        ]),
    GetPage(
        name: Routes.INDIVIDUAL_CHAT,
        binding: IndividualChatBinding(),
        transition: Transition.fadeIn,
        page: () => const IndividualChatScreen()),
    GetPage(
        name: Routes.SHELTER_PROFILE,
        binding: ShelterProfileBinding(),
        transition: Transition.fadeIn,
        page: () => const ShelterProfileScreen()),
  ];
}
