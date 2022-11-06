import 'package:flutter/material.dart';
import 'models/User.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("任务详情"),
        centerTitle: true,
      ),
      body: Center(child: Text(widget.user.username)),
    );
  }
}