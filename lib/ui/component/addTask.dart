import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/database/model/task.dart';
import 'package:todo/ui/database/MyDatabase.dart';

class AddTask extends StatelessWidget {
  tasks task;
  AddTask(this.task);
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(30),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              height: double.infinity,
              width: 4,
              color: Colors.blue,
              padding: const EdgeInsets.all(20),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    task.title ?? "",
                    style: const TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Text(
                    task.title??'' ,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
              child: const Icon(Icons.done),
            )
          ],
        ),
      ),
    );
  }

}
