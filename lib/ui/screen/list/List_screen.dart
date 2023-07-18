import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/component/addTask.dart';
import 'package:todo/ui/database/model/task.dart';
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:todo/ui/provider/AuthProvider.dart';

class List_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Container(
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot<tasks>>(
              future: MyDatabase.getTask(provider.AccountUser?.id ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                var listTasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  itemCount: listTasks?.length ??0,
                  itemBuilder: (context, index) {return AddTask(listTasks![index]);},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
