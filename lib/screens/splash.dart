import 'package:flutter/material.dart';
import 'package:provider_todo_list/utils/routers.dart';

import '../provider/database/db_provider.dart';
import 'Authentication/login.dart';
import 'TaskPage/homePage.dart';

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
       DatabaseProvider().getToken().then((value) {
         if (value == '') {
           PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
         } else {
           PageNavigator(ctx: context).nextPageOnly(page: const  HomePage());
         }
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo() ,),
    );
  }
}
