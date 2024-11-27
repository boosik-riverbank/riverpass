import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpass/onboarding/onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {

  @override
  void init(BuildContext context) {
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Onboarding().onboardData().then((goBalance) {
        if (goBalance) {
          context.go('/balance');
        } else {
          context.go("/login");
        }
      });
    });

    return Scaffold(
      // body: Center(
      //   child: SvgPicture.asset('asset/image/splash_logo.svg'),
      // )
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF53B1FD),
        child: Center(
          child: Image.asset("asset/image/riverpass.png", width: 100),
        )
      )
    );
  }

}