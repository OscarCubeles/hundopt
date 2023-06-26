import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'routes/routes.dart';
import 'app_binding.dart';
import 'themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dependency_injection.dart';

/// The [main] function is the entry point of the application.
///
/// This function initializes Firebase, runs the `App` widget, and initializes the dependencies of the application using `DependencyInjection.init()`.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
  await DependencyInjection.init();
}

/// The [App] widget is a [StatelessWidget] that returns a [GetMaterialApp] widget.
/// The [GetMaterialApp] widget is a [MaterialApp] widget that uses the `Get` package for state management.
/// It defines the initial route of the application, the default transition animation, the pages of the application,
/// the initial binding, the smart management strategy, the title of the application, the theme of the application,
/// and the builder for the `EasyLoading` widget.
class App extends StatelessWidget {
  const App({super.key});

  /// Builds the  [GetMaterialApp] widget with a [MaterialApp] widget that uses the `Get` package for state management.
  /// It defines the initial route of the application, the default transition animation, the pages of the application,
  /// the initial binding, the smart management strategy, the title of the application, the theme of the application,
  /// and the builder for the `EasyLoading` widget.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'Hündopt',
      theme: LightTheme.theme(),
      builder: EasyLoading.init(),
    );
  }
}
