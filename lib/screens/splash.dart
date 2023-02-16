import 'package:flutter/material.dart';
import 'package:provider_todo_list/utils/routers.dart';

import 'Authentication/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  void navigate(){
    Future.delayed(const Duration(seconds: 3), (){
       PageNavigator(ctx: context).nextPage(page: const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo() ,),
    );
  }
}
