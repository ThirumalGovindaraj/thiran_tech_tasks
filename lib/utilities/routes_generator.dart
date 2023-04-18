import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/bloc/email/email_screen.dart';
import 'package:tasks/bloc/firebase/firebase_screen.dart';
import 'package:tasks/bloc/firebase_list/argument.dart';
import 'package:tasks/bloc/firebase_list/firebase_data_list_screen.dart';
import 'package:tasks/bloc/github/github_screen.dart';
import 'package:tasks/bloc/splash/splash_screen.dart';
import 'package:tasks/utilities/routes.dart';

import '../bloc/email_list/email_list_screen.dart';
import '../bloc/github/github_pagination.dart';
import '../bloc/home/home_screen.dart';

class AppRoutes {
  static final routes = {
    Routes.splash: (context) => const SplashScreen(),
    Routes.home: (context) => const HomeScreen(),
    Routes.github: (context) => const GithubListView(),
    Routes.email: (context) => const EmailScreen(),
    Routes.firebase: (context) => const FirebaseScreen(),
    Routes.emailList: (context) => const TransactionListScreen(),
    Routes.firebaseList: (context) =>
        FirebaseDataListScreen(args: Argument(""),),
    // Routes.splash: (context) => const SplashScreen(),
  };

  static Route<dynamic> errorRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(
            child: Text("Page not found"),
          )),
    );
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments as Argument;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.github:
        return MaterialPageRoute(
          builder: (context) => const GithubListView(),
        );
      case Routes.email:
        return MaterialPageRoute(
          builder: (context) => const EmailScreen(),
        );

      case Routes.emailList:
        return MaterialPageRoute(
          builder: (context) => const TransactionListScreen(),
        );

      case Routes.firebaseList:
        return MaterialPageRoute(
          builder: (context) => FirebaseDataListScreen(
            args: args,
          ),
        );
      default:
        return errorRoutes(settings);
    }
  }
}
