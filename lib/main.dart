import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/home/home_screen.dart';
import 'package:tasks/utilities/app_color.dart';
import 'package:tasks/utilities/app_routes.dart';
import 'package:tasks/utilities/routes.dart';

import 'bloc/email/email_bloc.dart';
import 'bloc/github/github_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<EmailBloc>(
            create: (BuildContext context) => EmailBloc(EmailInitial()),
          ),
          BlocProvider<GithubBloc>(
            create: (BuildContext context) => GithubBloc(GithubInitial()),
          ),
        ],
        child: MaterialApp(
          title: 'Thiran Tech Tasks',
          theme: ThemeData(
              primarySwatch: AppColor.teal,
              iconTheme: const IconThemeData(color: Colors.white),
              textTheme:
                  const TextTheme(labelMedium: TextStyle(color: Colors.white))),
          home: const HomeScreen(),
          initialRoute: Routes.splash,
          routes: AppRoutes.routes,
        ));
  }
}
