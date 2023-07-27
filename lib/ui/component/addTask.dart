
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/database/model/task.dart';
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/ui/component/dialog.dart';
import '../provider/AuthProvider.dart';

class AddTask extends StatefulWidget {
  tasks task;
  AddTask(this.task);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool selectdone = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext) {
                deletTask();
              },
              backgroundColor: const Color(0xFFFE4A49),
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
          ],
        ),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                height: double.infinity,
                width: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:
                    widget.task.done == true ? Colors.green : Colors.blue),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(widget.task.title ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.task.done == true
                              ? Colors.green
                              : Colors.blue,
                        ),
                        textAlign: TextAlign.start),
                    Text('${widget.task.selectTime}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start)
                  ],
                ),
              ),
              widget.task.done == true
                  ? const Text(
                'Done!',
                style: TextStyle(fontSize: 20, color: Colors.green),
              )
                  : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.task.done == true
                        ? Colors.green
                        : Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    widget.task.done = true;

                    setState(() {});
                  },
                  child: Icon(Icons.done)),
              const SizedBox(
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  void deletTask() {
    var provider = Provider.of<AuthProvider>(context, listen: false);

    dialog.showMassage(context, 'Do you want to delete task?',
        positiveAction: 'ok', negativeAction: 'cancel', postive: () async {
          await MyDatabase.deleteTask(
              provider.AccountUser?.id ?? '', widget.task.Id ?? "");
        });
  }
}

