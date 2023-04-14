import 'package:tasks/bloc/email/email_screen.dart';
import 'package:tasks/bloc/github/github_screen.dart';
import 'package:tasks/bloc/splash/splash_screen.dart';
import 'package:tasks/utilities/routes.dart';

import '../bloc/home/home_screen.dart';

class AppRoutes {
  static final routes = {
    Routes.splash: (context) => const SplashScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.github: (context) => const GithubScreen(),
    Routes.email: (context) => const EmailScreen(),
    // Routes.splash: (context) => const SplashScreen(),
  };
}
