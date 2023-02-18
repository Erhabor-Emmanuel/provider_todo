import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../provider/database/db_provider.dart';
import '../../utils/routers.dart';
import 'Local widgets/tasl_view_container.dart';
import 'add_taskl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List task = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                ///logout
                 DatabaseProvider().logOut(context);
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: task.isNotEmpty? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Todo List is empty',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  PageNavigator(ctx: context).nextPage(page: const CreateTaskPage());
                },
                child: Text(
                  'Create a task',
                  style: TextStyle(fontSize: 18, color: grey),
                ),
              ),
            ],
          ),
        ) : ListView(
          children: List.generate(5, (index){
            return TaskField(
              initial: "${index + 1}",
              title: 'hello',
              subtitle: 'time',
              isCompleted: false,
              taskId: 'id',
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          PageNavigator(ctx: context).nextPage(page: const CreateTaskPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
