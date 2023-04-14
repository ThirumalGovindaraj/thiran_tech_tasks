import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utilities/icon_utils.dart';
import '../../utilities/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, Routes.home);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SvgPicture.asset(IconUtils.logo,semanticsLabel: 'Acme Logo')],
      ),
    );
  }
}
