import 'package:flutter/material.dart';
import 'package:provider_todo_list/widgets/button.dart';

import '../../utils/routers.dart';
import '../../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login ')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  customTextField(
                    title: 'Email',
                    controller: _email,
                    hint: 'Enter you valid email address',
                  ),
                  customTextField(
                    title: 'Password',
                    controller: _password,
                    hint: 'Enter your secured password',
                  ),
                  customButton(
                      text: 'Login',
                      tap: (){},
                      context: context,
                      status: false
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const RegisterPage());
                    },
                    child: const Text('Register Instead'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
